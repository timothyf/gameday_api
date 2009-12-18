require 'team'
require 'pitching_appearance'
require 'batting_appearance'
require 'gameday_fetcher'
require 'line_score'
require 'hpricot'
require 'rexml/document'
require 'gameday_util'


# Parses the MLB Gameday XML representation of a boxscore and returns data in easy to use
# arrays and hashes.  Can be used along with a view template to easily create a displayable
# box score.
class BoxScore
  
  attr_accessor :xml_data, :gid, :game, :linescore, :game_info, :home_batting_text, :away_batting_text
  
  attr_accessor :game_id, :game_pk, :home_sport_code, :away_team_code, :home_team_code, :away_id, :home_id, :away_fname, :home_fname, :away_sname, :home_sname
  attr_accessor :date, :away_wins, :away_loss, :home_wins, :home_loss, :status_ind
  
  
  def initialize
    super
  end
  
  
  # Loads the boxscore XML from the MLB gameday server and parses it using REXML
  def load_from_id(gid)
    @gid = gid
    @game = Game.new(gid)
    @xml_data = GamedayFetcher.fetch_boxscore(gid)
    @xml_doc = REXML::Document.new(@xml_data)
    self.linescore = LineScore.new
    if @xml_doc.root
      self.set_basic_info
      self.linescore.init(@xml_doc.root.elements["linescore"])
      self.game_info = @xml_doc.root.elements["game_info"].text
      if @xml_doc.root.elements["batting[@team_flag='home']/text_data"]
        self.home_batting_text = @xml_doc.root.elements["batting[@team_flag='home']/text_data"].text
        self.away_batting_text = @xml_doc.root.elements["batting[@team_flag='away']/text_data"].text
      end
    end
  end
  
  
  # Retrieves basic game data from the XML root element and sets in object
  def set_basic_info
    self.game_id = @xml_doc.root.attributes["game_id"]
    self.game_pk = @xml_doc.root.attributes["game_pk"]
    self.home_sport_code = @xml_doc.root.attributes["home_sport_code"]
    self.away_team_code = @xml_doc.root.attributes["away_team_code"]
    self.home_team_code = @xml_doc.root.attributes["home_team_code"]
    self.away_id = @xml_doc.root.attributes["away_id"]
    self.home_id = @xml_doc.root.attributes["home_id"]
    self.away_fname = @xml_doc.root.attributes["away_fname"]
    self.home_fname = @xml_doc.root.attributes["home_fname"]
    self.away_sname = @xml_doc.root.attributes["away_sname"]
    self.home_sname = @xml_doc.root.attributes["home_sname"]
    self.date = @xml_doc.root.attributes["date"]
    self.away_wins = @xml_doc.root.attributes["away_wins"]
    self.away_loss = @xml_doc.root.attributes["away_loss"]
    self.home_wins = @xml_doc.root.attributes["home_wins"]
    self.home_loss = @xml_doc.root.attributes["home_loss"]
    self.status_ind = @xml_doc.root.attributes["status_ind"]
  end
  
  
  # Saves an HTML version of the boxscore
  def dump_to_file
    GamedayUtil.save_file("boxscore.html", self.to_html('boxscore.html.erb'))
  end
  
  
  # Converts the boxscore into a formatted HTML representation.
  # Relies on the boxscore.html.erb template for describing the layout
  def to_html(template_filename)
    cities = get_cities
    innings = get_innings      
    tots =  get_linescore_totals     
    home_pitchers = get_pitchers('home')
    away_pitchers = get_pitchers('away')
    home_batters = get_batters('home')
    away_batters = get_batters('away')
    home_batters_text = self.home_batting_text
    away_batters_text = self.away_batting_text
    game_info = get_game_info
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    template = ERB.new File.new(File.expand_path(File.dirname(__FILE__) + "./" + template_filename)).read, nil, "%"  
    return template.result(binding)
  end
  
  
  # Returns an array of the city names for the teams playing the game
  #    [0] = away
  #    [1] = home
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
  
  
  # Returns a count of the number of innings played
  # very useful for detecting extra inning games
  def get_innings_count
    count = 0
    @xml_doc.elements.each("boxscore/linescore/inning_line_score") { |element|
      count = count + 1
    }
    count
  end
  
  
  def get_innings
    innings = []
    (1..get_innings_count).each do |num|
      innings.push get_inning_score(num)
    end
    return innings
  end
  
  
  # Returns an array containg two child arrays, one representing the home team
  # totals, and the other representing the away team totals.  
  # Each child array contains 3 elements (runs, hits, errors)
  def get_linescore_totals
    totals, home, away = [], [], []
    if @xml_doc.root
      away.push self.linescore.away_team_runs
      away.push self.linescore.away_team_hits
      away.push self.linescore.away_team_errors
      
      home.push self.linescore.home_team_runs
      home.push self.linescore.home_team_hits
      home.push self.linescore.home_team_errors
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
    count = 1
    @xml_doc.elements.each("boxscore/pitching[@team_flag='#{home_or_away}']/pitcher") { |element| 
      pitcher = PitchingAppearance.new
      pitcher.init(element, count)
      count = count + 1
      pitchers.push pitcher
    }   
    return pitchers
  end
  
  
  # Returns an array of hashes where each hash holds data for a batter whom appeared
  # in the game.  Specify either home or away team batters.
  def get_batters(home_or_away)
    batters = []
    @xml_doc.elements.each("boxscore/batting[@team_flag='#{home_or_away}']/batter") { |element| 
      batter = BattingAppearance.new
      batter.init(element)
      batters.push batter
    }
    return batters
  end
  
  
  # Returns a 2 element array of leadoff hitters for this game.
  #     [0] = visitor's leadoff hitter
  #     [1] = home's leadoff hitter
  def get_leadoff_hitters
    results = []
    away = @xml_doc.elements["boxscore/batting[@team_flag='away']/batter"]
    away_batter = BattingAppearance.new
    away_batter.init(away)
    results << away_batter
    home = @xml_doc.elements["boxscore/batting[@team_flag='home']/batter"]
    home_batter = BattingAppearance.new
    home_batter.init(home)
    results << home_batter
    results
  end
  
  
  # Returns a 2 element array of cleanup hitters for this game.
  #     [0] = visitor's cleanup hitter
  #     [1] = home's cleanup hitter
  def get_cleanup_hitters
    results = []
    away = @xml_doc.elements["boxscore/batting[@team_flag='away']/batter[@bo='400']"]
    away_batter = BattingAppearance.new
    away_batter.init(away)
    results << away_batter
    home = @xml_doc.elements["boxscore/batting[@team_flag='home']/batter[@bo='400']"]
    home_batter = BattingAppearance.new
    home_batter.init(home)
    results << home_batter
    results
  end
  
  
  def get_game_info
    return self.game_info
  end
  
  
end