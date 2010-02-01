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
  
  # complex attributes
  attr_accessor :innings, :cities, :linescore_totals, :pitchers, :batters
  
  
  # Loads the boxscore XML from the MLB gameday server and parses it using REXML
  def load_from_id(gid)
    @gid = gid
    @xml_data = GamedayFetcher.fetch_boxscore(gid)
    @xml_doc = REXML::Document.new(@xml_data)
    if @xml_doc.root
      set_basic_info
      @linescore = LineScore.new
      @linescore.init(@xml_doc.root.elements["linescore"])
      @game_info = @xml_doc.root.elements["game_info"].text
	  set_batting_text
      set_cities
      set_pitchers
      set_batters
    end
  end
  
  
  # Retrieves basic game data from the XML root element and sets in object
  def set_basic_info
    @game_id = @xml_doc.root.attributes["game_id"]
    @game_pk = @xml_doc.root.attributes["game_pk"]
    @home_sport_code = @xml_doc.root.attributes["home_sport_code"]
    @away_team_code = @xml_doc.root.attributes["away_team_code"]
    @home_team_code = @xml_doc.root.attributes["home_team_code"]
    @away_id = @xml_doc.root.attributes["away_id"]
    @home_id = @xml_doc.root.attributes["home_id"]
    @away_fname = @xml_doc.root.attributes["away_fname"]
    @home_fname = @xml_doc.root.attributes["home_fname"]
    @away_sname = @xml_doc.root.attributes["away_sname"]
    @home_sname = @xml_doc.root.attributes["home_sname"]
    @date = @xml_doc.root.attributes["date"]
    @away_wins = @xml_doc.root.attributes["away_wins"]
    @away_loss = @xml_doc.root.attributes["away_loss"]
    @home_wins = @xml_doc.root.attributes["home_wins"]
    @home_loss = @xml_doc.root.attributes["home_loss"]
    @status_ind = @xml_doc.root.attributes["status_ind"]
  end
  
  
  # Saves an HTML version of the boxscore
  def dump_to_file
    GamedayUtil.save_file("boxscore.html", to_html('boxscore.html.erb'))
  end
  
  
  # Converts the boxscore into a formatted HTML representation.
  # Relies on the boxscore.html.erb template for describing the layout
  def to_html(template_filename)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    template = ERB.new File.new(File.expand_path(File.dirname(__FILE__) + "/" + template_filename)).read, nil, "%"  
    return template.result(binding)
  end
  
  
  def set_batting_text
	  if @xml_doc.root.elements["batting[@team_flag='home']/text_data"]
	    @home_batting_text = @xml_doc.root.elements["batting[@team_flag='home']/text_data"].text
	    @away_batting_text = @xml_doc.root.elements["batting[@team_flag='away']/text_data"].text
	  end
  end
  
  
  # Sets an array of the city names for the teams playing the game
  #    [0] = away
  #    [1] = home
  def set_cities
    @cities = []
    if @xml_doc.root
      @cities.push @xml_doc.root.attributes["away_sname"]
      @cities.push @xml_doc.root.attributes["home_sname"]
    else
      @cities.push 'unknown'
      @cities.push 'unknown'
    end
  end
  
  
  # Sets an array of hashes where each hash holds data for a pitcher whom appeared
  # in the game.  Specify either home or away team pitchers.
  def set_pitchers
    @pitchers, away_pitchers, home_pitchers = [], [], []
    count = 1
    @xml_doc.elements.each("boxscore/pitching[@team_flag='away']/pitcher") { |element| 
      pitcher = PitchingAppearance.new
      pitcher.init(element, count)
      count += 1
      away_pitchers.push pitcher
    }   
    count = 1
    @xml_doc.elements.each("boxscore/pitching[@team_flag='home']/pitcher") { |element| 
      pitcher = PitchingAppearance.new
      pitcher.init(element, count)
      count += 1
      home_pitchers.push pitcher
    }   
    @pitchers << away_pitchers
    @pitchers << home_pitchers
  end
  
  
  # Sets an array of hashes where each hash holds data for a batter whom appeared
  # in the game.  Specify either home or away team batters.
  def set_batters
    @batters, away_batters, home_batters = [], [], []
    @xml_doc.elements.each("boxscore/batting[@team_flag='away']/batter") { |element| 
      batter = BattingAppearance.new
      batter.init(element)
      away_batters.push batter
    }
    @xml_doc.elements.each("boxscore/batting[@team_flag='home']/batter") { |element| 
      batter = BattingAppearance.new
      batter.init(element)
      home_batters.push batter
    }
    @batters << away_batters
    @batters << home_batters
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
  
  
end