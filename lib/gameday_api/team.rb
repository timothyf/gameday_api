require_relative 'gameday_util'
require_relative 'game'
require_relative 'gameday'
require_relative 'schedule'

module GamedayApi

  # This class
  class Team
  
    START_MONTH = 4  # April
    END_MONTH = 10   # October
  
    attr_accessor :abrev, :city, :name, :league, :games
  
    # Setup team names, abbreviations, and league
    def initialize(abrev)
      if (abrev && abrev != '')
        @abrev = abrev
        if Team.teams[@abrev]
          @city = Team.teams[@abrev][0]
          @name = Team.teams[@abrev][1]
          if Team.teams[@abrev].length > 2
            @league = Team.teams[@abrev][2]
          end
        else
          @city = @abrev
          @name = @abrev
          @league = ''
        end
      else
          @city = ''
          @name = ''
          @league = ''
      end
    end
  
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
      @@abrevs['mon'] = ['Montreal','Expos','National']
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
  
  
    def self.teams
      
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
      if !@games
        puts 'Finding all games for team...'
        results = []
        (START_MONTH..END_MONTH).each do |month|
          puts "Month: " + month.to_s
          month_s = GamedayUtil.convert_digit_to_string(month)
          (1..31).each do |date|
            if !GamedayUtil.is_date_valid(month, date)
              next
            end
            date_s = GamedayUtil.convert_digit_to_string(date)
            games = games_for_date(year, month_s, date_s)
            if games
              # make sure game was not postponed
              good_games = games.select { |g| g.get_boxscore.status_ind != 'P' }
              good_games.each do |game|
                results << game
              end
            end
          end
        end
        @games = results
      end
      @games
    end
  
  
    # Returns an array of all home games for this team for the specified season
    def all_home_games(year)
      games = all_games(year)
      results = games.select {|g| g.home_team_abbrev == @abrev }
    end
  
  
    # Returns an array of all away games for this team for the specified season
    def all_away_games(year)
      games = all_games(year)
      results = games.select {|g| g.visit_team_abbrev == @abrev }
    end
  
  
    # Returns an array of the team's game objects for the date passed in.
    def games_for_date(year, month, day)
      games_page = GamedayFetcher.fetch_games_page(year, month, day)
      gids = find_gid_for_date(year, month, day, games_page)
      if gids
        results = gids.collect {|gid| Game.new(gid) }
      else 
        results = nil
      end
      results
    end
  
  
    # Returns an array of BattingAppearance containing the leadoff hitters for each game of the specified season.
    def get_leadoff_hitters_by_year(year)
      results = []
      games = all_games(year)
      games.each do |game|
        boxscore = game.get_boxscore
        leadoffs = boxscore.get_leadoff_hitters
        if game.home_team_abbrev == @abrev
          results << leadoffs[1]
        else
          results << leadoffs[0]
        end
      end
      results
    end
  
  
    # Returns an array of BattingAppearance of all hitters who have led off at least one game during the specified season 
    def get_leadoff_hitters_unique(year)
      hitters = get_leadoff_hitters_by_year(year)
      h = {}
      hitters.each {|hitter| h[hitter.batter_name]=hitter}
      h.values
    end
  
  
    # Returns an array containing the cleanup hitters for each game of the specified season.
    # The cleanup hitter is the 4th hitter in the batting order
    def get_cleanup_hitters_by_year(year)
      results = []
      games = all_games(year)
      games.each do |game|
        boxscore = game.get_boxscore
        hitters = boxscore.get_cleanup_hitters
        if game.home_team_abbrev == @abrev
          results << hitters[1]
        else
          results << hitters[0]
        end
      end
      results
    end
  
  
    # Returns an array of all hitters who have hit in the cleanup spot (4) at least one game during the specified season 
    def get_cleanup_hitters_unique(year)
      hitters = get_cleanup_hitters_by_year(year)
      h = {}
      hitters.each {|hitter| h[hitter.batter_name]=hitter}
      h.values
    end
  
  
    def get_start_pitcher_appearances_by_year(year)
      pitchers = []
      games = all_games(year)
      games.each do |game|
        starters = game.get_starting_pitchers
        if game.home_team_abbrev == @abrev
          pitchers << starters[1]
        else
          pitchers << starters[0]
        end
      end
      pitchers
    end
  
  
    # Returns an array of all pitchers who have started at least one game during the specified season
    def get_starters_unique(year)
      pitchers = get_start_pitcher_appearances_by_year(year)
      h = {}
      pitchers.each {|pitcher| h[pitcher.pitcher_name]=pitcher}
      h.values
    end
  
  
    def get_close_pitcher_appearances_by_year(year)
      pitchers = []
      games = all_games(year)
      games.each do |game|
        closers = game.get_closing_pitchers
        if game.home_team_abbrev == @abrev
          pitchers << closers[1]
        else
          pitchers << closers[0]
        end
      end
      pitchers
    end
  
  
    # Returns an array of all pitchers who have closed at least one game during the specified season
    def get_closers_unique(year)
      pitchers = get_close_pitcher_appearances_by_year(year)
      h = {}
      pitchers.each {|pitcher| h[pitcher.pitcher_name]=pitcher}
      h.values
    end
  
  
    # Returns a count of the number of quality starts for this team for the specified year.
    def quality_starts_count(year)
      count = 0
      games = all_games(year)
      games.each do |game|
        starters = game.get_starting_pitchers
        if game.home_team_abbrev == @abrev
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
  
  
    # Returns an array of all the games for this team for the year and month specified
    def get_games_for_month(year, month)
    
    end
  
  
    # Returns a game object representing the opening day game for this team for
    # the season passed in.
    def get_opening_day_game(year)
      schedule = Schedule.new(year)
      oday = schedule.get_opening_day
      oday_array = GamedayUtil.parse_date_string(oday)
      games = games_for_date(oday_array[0], oday_array[1], oday_array[2])
      if games[0] == nil
        games = games_for_date(oday_array[0], 
                               oday_array[1], 
                               GamedayUtil.convert_digit_to_string(oday_array[2].to_i + 1))
      end
      return games[0]
    end
  
  
    # Returns a Roster object representing the opening day roster for this team
    # for the specified year.
    def opening_day_roster(year)
      game = get_opening_day_game(year)
      rosters = game.get_rosters
      rosters[0].team_name == city + ' ' + name ? rosters[0] : rosters[1]
    end


    private
  
    # Returns an array of the game ids associated with the given date and team
    # because of double-headers it is possible for one team to play more than one game
    # on a single date.
    # Each game listing looks like this:
    #    <li><a href="gid_2009_09_15_kcamlb_detmlb_1/">gid_2009_09_15_kcamlb_detmlb_1/</a></li>
    def find_gid_for_date(year, month, day, games_page)
      begin 
        results = []
        if games_page
          # look for game listings
          doc = Nokogiri::HTML(games_page) 
          a = doc.css('a')  
          (a/"a").each do |link|
            # game listings include the 'gid' characters
            if link.text.include?('gid') && link.text.include?(@abrev)
              str = link.text
              results << str[5..str.length-2]
            end
          end
          return results
        end
        puts "No games data found for #{year}, #{month}, #{day}, #{@abrev}."
        return nil
      rescue
        puts "Exception in find_gid_for_date: No games data found for #{year}, #{month}, #{day}, #{@abrev}."
      end
    end
  
  
  end
end