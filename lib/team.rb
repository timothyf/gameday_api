# This class


require 'gameday_util'
require 'game'
require 'gameday'

class Team
  
  attr_accessor :abrev, :city, :name, :league
  
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
    results = []
    (4..10).each do |month|
      month_s = GamedayUtil.convert_digit_to_string(month)
      (1..31).each do |date|
        if month==4 and date<5 # start from 4/5 onward
          next
        end
        date_s = GamedayUtil.convert_digit_to_string(date)
        games = games_for_date(year, month_s, date_s)
        if games
          games.each do |game|
            results << game
          end
        end
      end
    end
    results
  end
  
  
  # Returns an array of the team's game objects for the date passed in.
  def games_for_date(year, month, day)
    results = []
    api = Gameday.new
    url = GamedayUtil.build_day_url(year, month, day)
    connection = GamedayUtil.get_connection(url)
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
  def find_gid_for_date(year, month, day, connection)
    begin 
      results = []
      if connection
        @hp = Hpricot(connection) 
        a = @hp.at('ul')  
        (a/"a").each do |link|
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

end