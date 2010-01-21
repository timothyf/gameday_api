require 'gameday_util'
require 'team'
require 'players'


# This class represents a single MLB game
class Game
  
  attr_accessor :gid, :home_team_name, :home_team_abbrev, :visit_team_name, :visit_team_abbrev, 
                :year, :month, :day, :game_number, :visiting_team, :home_team
  attr_accessor :boxscore, :rosters
  
  # additional attributes from master_scoreboard.xml
  attr_accessor :scoreboard_game_id, :ampm, :venue, :game_pk, :time, :time_zone, :game_type
  attr_accessor :away_name_abbrev, :home_name_abbrev, :away_code, :away_file_code, :away_team_id
  attr_accessor :away_team_city, :away_team_name, :away_division
  attr_accessor :home_code, :home_file_code, :home_team_id, :home_team_city, :home_team_name, :home_division
  attr_accessor :day, :gameday_sw, :away_games_back, :home_games_back, :away_games_back_wildcard, :home_games_back_wildcard
  attr_accessor :venue_w_chan_loc, :gameday, :away_win, :away_loss, :home_win, :home_loss, :league
  
  attr_accessor :status  # An instance of GameStatus object
  attr_accessor :homeruns # an array of players with homeruns in the game
  attr_accessor :winning_pitcher, :losing_pitcher, :save_pitcher  # Instances of Player object
  attr_accessor :away_innings, :home_innings  # An arry of one element for each inning, the element is the home or away score
  attr_accessor :home_hits, :away_hits, :home_errors, :away_errors, :home_runs, :away_runs
  
  def initialize(gid)
    team = Team.new('')
    if gid
      self.gid = gid
      info = GamedayUtil.parse_gameday_id('gid_'+gid)
      self.home_team_abbrev = info["home_team_abbrev"]
      self.visit_team_abbrev = info["visiting_team_abbrev"]
      self.visiting_team = Team.new(self.visit_team_abbrev )
      self.home_team = Team.new(self.home_team_abbrev )
      self.year = info["year"]
      self.month = info["month"]
      self.day = info["day"]
      self.game_number = info["game_number"]
      self.home_team_name = Team.teams[self.home_team_abbrev][0]
      self.visit_team_name = Team.teams[self.visit_team_abbrev][0]
    end
  end
  
  
  # Setup a Game object from data read from the  master_scoreboard.xml file
  def load_from_scoreboard(element)
      @away_innings = []
      @home_innings = []
      self.scoreboard_game_id = element.attributes['id']
      self.ampm = element.attributes['ampm']
      self.venue = element.attributes['venue']
      self.game_pk = element.attributes['game_pk']
      self.time = element.attributes['time']
      self.time_zone = element.attributes['time_zone']
      self.game_type = element.attributes['game_type']
      self.away_name_abbrev = element.attributes['away_name_abbrev']
      self.home_name_abbrev = element.attributes['home_name_abbrev']
      self.away_code = element.attributes['away_code']
      self.away_file_code = element.attributes['away_file_code']
      self.away_team_id = element.attributes['away_team_id']
      self.away_team_city = element.attributes['away_team_city']
      self.away_team_name = element.attributes['away_team_name']
      self.away_division = element.attributes['away_division']
      self.home_code = element.attributes['home_code']
      self.home_file_code = element.attributes['home_file_code']
      self.home_team_id = element.attributes['home_team_id']
      self.home_team_city = element.attributes['home_team_city']
      self.home_team_name = element.attributes['home_team_name']
      self.home_division = element.attributes['home_division']
      self.day = element.attributes['day']
      self.gameday_sw = element.attributes['gameday_sw']
      self.away_games_back = element.attributes['away_games_back']
      self.home_games_back = element.attributes['home_games_back']
      self.away_games_back_wildcard = element.attributes['away_games_back_wildcard']
      self.home_games_back_wildcard = element.attributes['home_games_back_wildcard']
      self.venue_w_chan_loc = element.attributes['venue_w_chan_loc']
      self.gameday = element.attributes['gameday']
      self.away_win = element.attributes['away_win']
      self.away_loss = element.attributes['away_loss']
      self.home_win = element.attributes['home_win']
      self.home_loss = element.attributes['home_loss']
      self.league = element.attributes['league']
      
      set_innings(element)
      set_totals(element)
      set_pitchers(element)
      set_homeruns(element)
    end
    
    
    # Sets the away and home innings array containing scores by inning from data in the master_scoreboard.xml file
    def set_innings(element)
      element.elements.each("linescore/inning") { |element|
         @away_innings << element.attributes['away']
         @home_innings << element.attributes['home']
      }
    end
    
    
    # Sets the Runs/Hits/Errors totals from data in the master_scoreboard.xml file
    def set_totals(element)
      element.elements.each("linescore/r") { |runs|
         @away_runs = runs.attributes['away']
         @home_runs = runs.attributes['home']
      }
      element.elements.each("linescore/h") { |hits|
         @away_hits = hits.attributes['away']
         @home_hits = hits.attributes['home']
      }
      element.elements.each("linescore/e") { |errs|
         @away_errors = errs.attributes['away']
         @home_errors = errs.attributes['home']
      }
    end
    
    
    # Sets a list of players who had homeruns in this game from data in the master_scoreboard.xml file
    def set_homeruns(element)
      @homeruns = []
      element.elements.each("home_runs/player") do |hr|
        player = Player.new
        player.last = hr.attributes['last']
        player.first = hr.attributes['first']
        player.hr = hr.attributes['hr']
        player.std_hr = hr.attributes['std_hr']
        player.team_code = hr.attributes['team_code']
        @homeruns << player
      end
    end
    
    
    # Sets the pitchers of record (win, lose, save) from data in the master_scoreboard.xml file
    def set_pitchers(element)
      element.elements.each("winning_pitcher") { |wp|
        @winning_pitcher = Player.new
        @winning_pitcher.first = wp.attributes['first']
        @winning_pitcher.last = wp.attributes['last']
        @winning_pitcher.wins = wp.attributes['wins']
        @winning_pitcher.losses = wp.attributes['losses']
        @winning_pitcher.era = wp.attributes['era']
      }
      element.elements.each("losing_pitcher") { |lp|
        @losing_pitcher = Player.new
        @losing_pitcher.first = lp.attributes['first']
        @losing_pitcher.last = lp.attributes['last']
        @losing_pitcher.wins = lp.attributes['wins']
        @losing_pitcher.losses = lp.attributes['losses']
        @losing_pitcher.era = lp.attributes['era']
      }
      element.elements.each("save_pitcher") { |sp|
        @save_pitcher = Player.new
        @save_pitcher.first = sp.attributes['first']
        @save_pitcher.last = sp.attributes['last']
        @save_pitcher.saves = sp.attributes['saves']
      }
    end
  
  
  # Returns an array of Game objects for each game for the specified day
  def self.find_by_date(year, month, day)
    begin 
      games = []
      connection = GamedayFetcher.fetch_gameday_connection(year, month, day)
      if connection
        @hp = Hpricot(connection) 
        a = @hp.at('ul')  
        (a/"a").each do |link|
          # look at each link inside of a ul tag
          if link.inner_html.include?('gid')
            # if the link contains the text 'gid' then it is a listing of a game
            str = link.inner_html
            gid = str[5..str.length-2]
            game = Game.new(gid)
            games.push game
          end
        end
      end
      connection.close
      return games
    rescue
      puts "No games data found for #{year}, #{month}, #{day}."
    end
  end
  
  
  # Returns a 2 element array containing the home and visiting rosters for this game
  #    [0] array of all visitor players
  #    [1] array of all home players
  def get_rosters
    if !self.rosters
      players = Players.new
      players.load_from_id(self.gid)
      self.rosters = players.rosters
    end
    self.rosters
  end
  
  
  # Returns a BoxScore object representing the boxscore for this game
  def get_boxscore
    if !self.boxscore
      box = BoxScore.new
      box.load_from_id(self.gid)
      self.boxscore = box
    end
    self.boxscore
  end
  
  
  # Saves an HTML version of the boxscore for the game
  def dump_boxscore
    if self.gid
      bs = get_boxscore
      GamedayUtil.save_file("boxscore.html", bs.to_html('boxscore.html.erb'))
    else
      puts "No data for input specified"
    end
  end
  

  # Returns an array containg two child arrays, one representing the home team
  # totals, and the other representing the away team totals.  
  # Each child array contains 3 elements (runs, hits, errors)
  def get_linescore
    if self.gid
      bs = get_boxscore
      bs.get_linescore_totals
    else
      puts "No data for input specified"
    end
  end
  
  
  # Returns a string containing the linescore in the following printed format:
  #   Away 1 3 1
  #   Home 5 8 0
  def print_linescore
    score = get_linescore
    output = self.visit_team_name + ' ' + score[0][0] + ' ' + score[0][1] + ' ' + score[0][2] + "\n"
    output += self.home_team_name + ' ' + score[1][0] + ' ' + score[1][1] + ' ' + score[1][2]
    output
  end
  
  
  # Returns an array of the starting pitchers for the game
  #    [0] = visiting team pitcher
  #    [1] = home team pitcher
  def get_starting_pitchers
    results = []
    results << get_pitchers('away')[0]
    results << get_pitchers('home')[0]
  end
  
  
  # Returns an array of the closing pitchers for the game
  #    [0] = visiting team pitcher
  #    [1] = home team pitcher
  def get_closing_pitchers
    results = []
    away_pitchers = get_pitchers('away')
    home_pitchers = get_pitchers('home')
    results << away_pitchers[(away_pitchers.size) - 1]
    results << home_pitchers[(home_pitchers.size) -1]
  end
  
  
  # Returns an array of all pitchers for either the home team or the away team.
  # The values in the returned array are PitchingAppearance instances
  def get_pitchers(home_or_away)
    if self.gid
      bs = get_boxscore
      bs.get_pitchers(home_or_away)
    else
      puts "No data for input specified"
    end
  end
  
  
  # Returns an array of either home or away batters for this game
  # home_or_away must be a string with value 'home' or 'away'
  # The values in the returned array are BattingAppearance instances
  def get_batters(home_or_away)
    if self.gid
      bs = get_boxscore
      bs.get_batters(home_or_away)
    else
      puts "No data for input specified"
    end
  end
  
  
  # Returns the starting lineups for this game in an array with 2 elements
  # results[0] = visitors
  # results[1] = home
  def get_lineups
    results = []
    results << get_batters('home')
    results << get_batters('away')
  end
  
  
  # Returns the pitchers for this game in an array with 2 elements
  # results[0] = visitors
  # results[1] = home
  def get_pitching
    results = []
    results << get_pitchers('away')
    results << get_pitchers('home')
  end
  
  
  # Returns the team abreviation of the winning team
  def get_winner
    
  end
  
  
  # Returns a 2 element array holding the game score
  #    [0] visiting team runs
  #    [1] home team runs
  def get_score
    
  end
  
  
  # Returns a string holding the game attendance value
  def get_attendance
    bs = get_boxscore
  end
  
  
  # Returns an array of Inning objects that represent each inning of the game
  def get_innings
    
  end
  
  
  # Returns an array of AtBat objects that represent each atbat of the game
  def get_atbats
    
  end
  
end

