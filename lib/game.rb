require 'gameday_util'
require 'team'
require 'players'


# This class represents a single MLB game
class Game
  
  attr_accessor :gid, :home_team_name, :home_team_abbrev, :visit_team_name, :visit_team_abbrev, 
                :year, :month, :day, :game_number, :visiting_team, :home_team
  attr_accessor :boxscore, :rosters
  
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

