# This class


require 'gameday_util'
require 'game'
require 'gameday'

class Team
  
  attr_accessor :abrev, :city, :name, :league, :games
  
  # Setup team names, abbreviations, and league
  def initialize(abrev)
    @@abrevs = {}
    @@abrevs['ana'] = ['Anaheim','Angels','American']
    @@abrevs['bos'] = ['Boston','Red Sox','American']
    @@abrevs['cha'] = ['Chicago','White Sox','American']
    @@abrevs['chn'] = ['Chicago','Cubs','National']
    @@abrevs['det'] = ['Detroit','Tigers','American']
    @@abrevs['ari'] = ['Arizona','Diamondbacks','National']
    @@abrevs['bal'] = ['Baltimore','Orioles','American']
    @@abrevs['cle'] = ['Cleveland','Indians','American']
    @@abrevs['col'] = ['Colorado','Rockies','National']
    @@abrevs['flo'] = ['Florida','Marlins','National']
    @@abrevs['cin'] = ['Cincinnati','Reds','National']
    @@abrevs['atl'] = ['Atlanta','Braves','National']
    @@abrevs['hou'] = ['Houston','Astros','National']
    @@abrevs['kca'] = ['Kansas City','Royals','American']
    @@abrevs['min'] = ['Minnesota','Twins','American']
    @@abrevs['mil'] = ['Milwaukee','Brewers','National']
    @@abrevs['nya'] = ['New York','Yankees','American']
    @@abrevs['nyn'] = ['New York','Mets','National']
    @@abrevs['oak'] = ['Oakland','As','American']
    @@abrevs['lan'] = ['Los Angeles','Dodgers','National']
    @@abrevs['pit'] = ['Pittsburgh','Pirates','National']
    @@abrevs['phi'] = ['Philadelphi','Phillies','National']
    @@abrevs['usa'] = ['USA','All-Stars']
    @@abrevs['jpn'] = ['Japan','All-Stars']
    @@abrevs['sln'] = ['St. Louis','Cardinals','National']
    @@abrevs['sfn'] = ['SanFrancisco','Giants','National']
    @@abrevs['sea'] = ['Seattle','Mariners','American']
    @@abrevs['sdn'] = ['San Diego','Padres','National']
    @@abrevs['tba'] = ['Tampa Bay','Devil Rays','American']
    @@abrevs['tex'] = ['Texas','Rangers','American']
    @@abrevs['tor'] = ['Toronto','Blue Jays','American']
    @@abrevs['was'] = ['Washington','Nationals','National']
    if (abrev && abrev != '')
      self.abrev = abrev
      self.city = Team.teams[self.abrev][0]
      self.name = Team.teams[self.abrev][1]
      if Team.teams[self.abrev].length > 2
        self.league = Team.teams[self.abrev][2]
      end
    end
  end
  
  
  def self.teams
    @@abrevs
  end
  
  
  # Returns a 2 element array specifying the two teams associated with the game id (gid) passed in.
  # teams[0] = visitor
  # teams[1] = home
  def self.get_teams_for_gid(gid)
    teams = []
    info = GamedayUtil.parse_gameday_id('gid_'+gid)
    home_team_abbrev = info["home_team_abbrev"]
    visit_team_abbrev = info["visiting_team_abbrev"]
    teams << Team.new(visit_team_abbrev)
    teams << Team.new(home_team_abbrev)
  end
  
  
  # Returns an array of all games for this team for the specified season
  def all_games(year)
    if !self.games
      puts 'Finding all games for team...'
      results = []
      (4..10).each do |month|  # look at April through October
        month_s = GamedayUtil.convert_digit_to_string(month)
        (1..31).each do |date|
          if month==4 and date<5 # start from 4/5 onward
            next
          end
          if (month == 4 and date == 31) ||  
             (month == 6 and date == 31) ||
             (month == 9 and date == 31)
             # skip dates which are invalid
            next
          end
          date_s = GamedayUtil.convert_digit_to_string(date)
          games = games_for_date(year, month_s, date_s)
          if games
            games.each do |game|
              # make sure game was not postponed
              if game.get_boxscore.status_ind != 'P'
                results << game
              end
            end
          end
        end
      end
      self.games = results
    else
      puts 'Using games previously retrieved...'
    end
    self.games
  end
  
  
  # Returns an array of all home games for this team for the specified season
  def all_home_games(year)
    results = []
    games = all_games(year)
    games.each do |game|
      if game.home_team_abbrev == self.abrev
        results << game
      end
    end
    results
  end
  
  
  # Returns an array of all away games for this team for the specified season
  def all_away_games(year)
    results = []
    games = all_games(year)
    games.each do |game|
      if game.away_team_abbrev == self.abrev
        results << game
      end
    end
    results
  end
  
  
  # Returns an array of the team's game objects for the date passed in.
  def games_for_date(year, month, day)
    results = []
    connection = GamedayFetcher.fetch_gameday_connection(year, month, day)
    gids = self.find_gid_for_date(year, month, day, connection)
    if gids
      gids.each do |gid|
        results << Game.new(gid)
      end
    else 
      results = nil
    end
    results
  end

  
  # Returns an array of the game ids associated with the given date and team
  # because of double-headers it is possible for one team to play more than one game
  # on a single date.
  # Each game listing looks like this:
  #    <li><a href="gid_2009_09_15_kcamlb_detmlb_1/"> gid_2009_09_15_kcamlb_detmlb_1/</a></li>
  def find_gid_for_date(year, month, day, connection)
    begin 
      results = []
      if connection
        # look for game listings
        @hp = Hpricot(connection) 
        a = @hp.at('ul')  
        (a/"a").each do |link|
          # game listings include the 'gid' characters
          if link.inner_html.include?('gid')
            if link.inner_html.include?(self.abrev)
              str = link.inner_html
              results << str[5..str.length-2]
            end
          end
        end
        connection.close
        return results
      end
      connection.close
      puts "No games data found for #{year}, #{month}, #{day}, #{self.abrev}."
      return nil
    rescue
      puts "Exception in find_gid_for_date: No games data found for #{year}, #{month}, #{day}, #{self.abrev}."
    end
  end
  
  
  # Returns an array containing the leadoff hitters for each game of the specified season.
  def get_leadoff_hitters_by_year(year)
    results = []
    games = self.all_games(year)
    games.each do |game|
      boxscore = game.get_boxscore
      leadoffs = boxscore.get_leadoff_hitters
      if game.home_team_abbrev == self.abrev
        results << leadoffs[1]
      else
        results << leadoffs[0]
      end
    end
    results
  end
  
  
  # Returns an array of all hitters who have led off at least one game during the specified season 
  def get_leadoff_hitters_unique(year)
    results = []
    games = self.all_games(year)
  end
  
  
  # Returns an array containing the cleanup hitters for each game of the specified season.
  # The cleanup hitter is the 4th hitter in the batting order
  def get_cleanup_hitters_by_year(year)
    results = []
    games = self.all_games(year)
    games.each do |game|
      boxscore = game.get_boxscore
      hitters = boxscore.get_cleanup_hitters
      if game.home_team_abbrev == self.abrev
        results << hitters[1]
      else
        results << hitters[0]
      end
    end
    results
  end
  
  
  # Returns an array of all hitters who have hit in the cleanup spot (4) at least one game during the specified season 
  def get_cleanup_hitters_unique(year)
    results = []
    games = self.all_games(year)
  end
  
  
  def get_start_pitcher_appearances_by_year(year)
    pitchers = []
    games = self.all_games(year)
    games.each do |game|
      starters = game.get_starting_pitchers
      if game.home_team_abbrev == self.abrev
        pitchers << starters[1]
      else
        pitchers << starters[0]
      end
    end
    pitchers
  end
  
  
  # Returns an array of all pitchers who have started at least one game during the specified season
  def get_starters_unique(year)
    pitchers = self.get_start_pitcher_appearances_by_year(year)
    h = {}
    pitchers.each {|pitcher| h[pitcher.pitcher_name]=pitcher}
    h.values
  end
  
  
  def get_close_pitcher_appearances_by_year(year)
    pitchers = []
    games = self.all_games(year)
    games.each do |game|
      closers = game.get_closing_pitchers
      if game.home_team_abbrev == self.abrev
        pitchers << closers[1]
      else
        pitchers << closers[0]
      end
    end
    pitchers
  end
  
  
  # Returns an array of all pitchers who have closed at least one game during the specified season
  def get_closers_unique(year)
    
  end
  
  
  # Returns a count of the number of quality starts for this team for the specified year.
  def quality_starts_count(year)
    count = 0
    games = self.all_games(year)
    games.each do |game|
      starters = game.get_starting_pitchers
      if game.home_team_abbrev == self.abrev
        if starters[1].quality_start?
          count = count + 1
        end
      else
        if starters[0].quality_start?
          count = count + 1
        end
      end
    end
    count
  end
  
  
  # Returns an array of all players who have played at least one game for this team during the specified season.
  def players_for_season(year)
    
  end

end