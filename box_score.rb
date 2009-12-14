require 'hpricot'
require 'rexml/document'
require 'gameday_util'


# Parses the MLB Gameday XML representation of a boxscore and returns data in easy to use
# arrays and hashes.  Can be used along with a view template to easily create a displayable
# box score.
class BoxScore

  # The MLB Gameday server URL
  GD2_MLB_BASE = "http://gd2.mlb.com/components/game"
  
  attr_accessor :xml_data, :gid
  
  
  def initialize
    @proxy_addr = '10.0.6.251'
    @proxy_port = '3128'
    super
  end
  
  
  # Loads the boxscore XML from the MLB gameday server and parses it using REXML
  def load_from_id(gid)
    @gid = gid
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = "#{GD2_MLB_BASE}/mlb/year_" + gameday_info['year'] + "/month_" + 
          gameday_info['month'] + "/day_" + gameday_info['day'] + "/gid_"+gid+"/boxscore.xml"   
    #puts url
    @xml_data = net_http.get_response(URI.parse(url)).body
    @xml_doc = REXML::Document.new(@xml_data) 
  end
  
  
  def load_from_date(year, month, day)
    
  end
  
  
  def load(year, month, day, gid)
    @gid = gid
    url = "#{GD2_MLB_BASE}/mlb/year_" + year + "/month_" + month + "/day_" + day + "/gid_"+gid+"/boxscore.xml"   
    @xml_data = net_http.get_response(URI.parse(url)).body
    @xml_doc = REXML::Document.new(@xml_data)
  end
  
  
  # Converts the boxscore into a formatted HTML representation.
  def to_html(template_filename)
    cities = get_cities
    innings = get_innings      
    tots =  get_linescore_totals     
    home_pitchers = get_pitchers('home')
    away_pitchers = get_pitchers('away')
    home_batters = get_batters('home')
    away_batters = get_batters('away')
    home_batters_text = get_batting_text('home')
    away_batters_text = get_batting_text('away')
    game_info = get_game_info
    
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    template = ERB.new File.new(template_filename).read, nil, "%"  
    return template.result(binding)
  end
  
  
  def get_cities
    results = []
    if @xml_doc.root
      results.push @xml_doc.root.attributes["away_sname"]
      results.push @xml_doc.root.attributes["home_sname"]
    else
      results.push 'unknown'
      results.push 'unknown'
    end
    return results
  end
  
  
  def get_inning_score(inning)  
    score = []
    if @xml_doc.root.elements["linescore/inning_line_score[@inning=#{inning}]"]
      score.push @xml_doc.root.elements["linescore/inning_line_score[@inning=#{inning}]"].attributes["away"]
      if @xml_doc.root.elements["linescore/inning_line_score[@inning=#{inning}]"].attributes["home"] != ''
        score.push @xml_doc.root.elements["linescore/inning_line_score[@inning=#{inning}]"].attributes["home"]
      else
        score.push '&nbsp;&nbsp;'
      end
    else
      score.push '&nbsp;&nbsp;'
      score.push '&nbsp;&nbsp;'
    end
    return score
  end
  
  
  def get_innings
    innings = []
    (1..9).each do |num|
      innings.push get_inning_score(num)
    end
    return innings
  end
  
  
  # Returns an array containg two child arrays, one representing the home team
  # totals, and the other representing the away team totals.  
  # Each child array contains 3 elements (runs, hits, errors)
  def get_linescore_totals
    totals = []
    home = []
    away = []
    if @xml_doc.root
      away.push @xml_doc.root.elements["linescore"].attributes["away_team_runs"]
      away.push @xml_doc.root.elements["linescore"].attributes["away_team_hits"]
      away.push @xml_doc.root.elements["linescore"].attributes["away_team_errors"]
      
      home.push @xml_doc.root.elements["linescore"].attributes["home_team_runs"]
      home.push @xml_doc.root.elements["linescore"].attributes["home_team_hits"]
      home.push @xml_doc.root.elements["linescore"].attributes["home_team_errors"]
    else
      away.push('')
      away.push('')
      away.push('')
      home.push('')
      home.push('')
      home.push('')
    end
    
    totals.push away
    totals.push home
    return totals
  end
  
  
  # Returns an array of hashes where each hash holds data for a pitcher whom appeared
  # in the game.  Specify either home or away team pitchers.
  def get_pitchers(home_or_away)
    pitchers = []
    @xml_doc.elements.each("boxscore/pitching[@team_flag='#{home_or_away}']/pitcher") { |element| 
      pitcher = {}
      pitcher['name'] = element.attributes['name']
      pitcher['out'] = element.attributes['out']
      pitcher['inn'] = convert_out_to_inn(element.attributes['out'])
      pitcher['er'] = element.attributes['er']
      pitcher['r'] = element.attributes['r']
      pitcher['h'] = element.attributes['h']
      pitcher['so'] = element.attributes['so']
      pitcher['hr'] = element.attributes['hr']
      pitcher['bb'] = element.attributes['bb']
      pitcher['w'] = element.attributes['w']
      pitcher['l'] = element.attributes['l']
      pitcher['era'] = element.attributes['era']
      pitcher['note'] = element.attributes['note']
      pitchers.push pitcher
    }   
    return pitchers
  end
  
  
  # Returns an array of hashes where each hash holds data for a batter whom appeared
  # in the game.  Specify either home or away team batters.
  def get_batters(home_or_away)
    batters = []
    @xml_doc.elements.each("boxscore/batting[@team_flag='#{home_or_away}']/batter") { |element| 
      batter = {}
      batter['name'] = element.attributes['name']
      batter['pos'] = element.attributes['pos']
      batter['ab'] = element.attributes['ab']
      batter['r'] = element.attributes['r']
      batter['bb'] = element.attributes['bb']
      batter['sf'] = element.attributes['sf']
      batter['h'] = element.attributes['h']
      batter['e'] = element.attributes['e']
      batter['d'] = element.attributes['d']
      batter['t'] = element.attributes['t']
      batter['hbp'] = element.attributes['hbp']
      batter['so'] = element.attributes['so']
      batter['hr'] = element.attributes['hr']
      batter['rbi'] = element.attributes['rbi']
      batter['sb'] = element.attributes['sb']
      batter['avg'] = element.attributes['avg']
      batters.push batter
    }
    return batters
  end


  def get_batting_text(home_or_away)
    return @xml_doc.root.elements["batting[@team_flag='#{home_or_away}']/text_data"].text
  end
  
  
  def get_game_info
    return @xml_doc.root.elements["game_info"].text
  end
  
  private
  def convert_out_to_inn(outs)
    num_out = outs.to_i
    part = num_out % 3
    return (num_out/3).to_s + '.' + part.to_s
  end
  
  def net_http
    if @proxy_addr
      return Net::HTTP::Proxy(@proxy_addr, @proxy_port)
    else
      return Net::HTTP
    end
  end
  
end