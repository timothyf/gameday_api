require 'gameday_util'
require 'team'

class Game
  
  attr_accessor :gid, :home_team_name, :home_team_abbrev, :visit_team_name, :visit_team_abbrev, 
                :year, :month, :day, :game_number
  
  def initialize(gid)
    team = Team.new('')
    if gid
      self.gid = gid
      info = GamedayUtil.parse_gameday_id('gid_'+gid)
      self.home_team_abbrev = info["home_team_abbrev"]
      self.visit_team_abbrev = info["visiting_team_abbrev"]
      self.year = info["year"]
      self.month = info["month"]
      self.day = info["day"]
      self.game_number = info["game_number"]
      self.home_team_name = Team.teams[self.home_team_abbrev][0]
      self.visit_team_name = Team.teams[self.visit_team_abbrev][0]
    end
  end
  
  
  def dump_boxscore
    if self.gid
      bs = BoxScore.new
      bs.load_from_id(self.gid)
      save_file("boxscore.html", bs.to_html('boxscore.html.erb'))
    else
      puts "No data for input specified"
    end
  end
  

  # Returns an array containg two child arrays, one representing the home team
  # totals, and the other representing the away team totals.  
  # Each child array contains 3 elements (runs, hits, errors)
  def get_linescore
    if self.gid
      bs = BoxScore.new
      bs.load_from_id(self.gid)
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
  
  
  def get_starter_home
    get_pitchers('home')[0]
  end
  
  
  def get_starter_away
    get_pitchers('away')[0]
  end
  
  
  def get_pitchers(home_or_away)
    if self.gid
      bs = BoxScore.new
      bs.load_from_id(self.gid)
      bs.get_pitchers('home')
    else
      puts "No data for input specified"
    end
  end
  
  
  def get_winner
    
  end
  
  
  def get_score
    
  end
  
end

