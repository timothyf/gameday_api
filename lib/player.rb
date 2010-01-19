# This class represents a single MLB player from a single MLB game
class Player
  
  # attributes from players.xml
  attr_accessor :gid, :pid, :first, :last, :num, :boxname, :rl, :position, :status, :bat_order, :game_position, :avg, :hr, :rbi, :wins, :losses, :era
  
  # attributes from batters/13353333.xml or pitchers/1222112.xml
  attr_accessor :team, :type, :height, :weight, :bats, :throws, :dob
    
  # object pointers
  attr_accessor :team_obj, :games, :appearances
  
  
  # Initializes a Player object by reading the player data from the players.xml file for the player specified by game id and player id.
  def load_from_id(gid, pid)
    self.gid = gid
    self.pid = pid
    # fetch players.xml file
    xml_doc = GamedayFetcher.fetch_players(gid)
    # find specific player in the file
    pelement = xml_doc.root.elements["team/player[@id=#{pid}]"]
    self.init(pelement, gid)
  end
  
  
  # Initialize a player object by reading data from the players.xml file
  def init(element, gid)
    self.gid = gid
    self.pid = element.attributes['id']
    self.first = element.attributes['first']
    self.last = element.attributes['last']
    self.num= element.attributes['num']
    self.boxname = element.attributes['boxname']
    self.rl, = element.attributes['rl']
    self.position = element.attributes['position']
    self.status = element.attributes['status']
    self.bat_order = element.attributes['bat_order']
    self.game_position = element.attributes['game_position']
    self.avg = element.attributes['avg']
    self.hr = element.attributes['hr']
    self.rbi = element.attributes['rbi']
    self.wins = element.attributes['wins']
    self.losses = element.attributes['losses']
    self.era = element.attributes['era'] 
      
    set_extra_info
  end
    
  
  # Set data that is read from the batter or pitcher file found in the batters/xxxxxxx.xml file or pitchers/xxxxxx.xml file
  def set_extra_info
    if self.position == 'P'
      xml_data = GamedayFetcher.fetch_pitcher(self.gid, self.pid)
    else
      xml_data = GamedayFetcher.fetch_batter(self.gid, self.pid)
    end
    xml_doc = REXML::Document.new(xml_data)
    self.team = xml_doc.root.attributes['team']
    self.type = xml_doc.root.attributes['type']
    self.height = xml_doc.root.attributes['height']
    self.weight = xml_doc.root.attributes['weight']
    self.bats = xml_doc.root.attributes['bats']
    self.throws = xml_doc.root.attributes['throws']
    self.dob = xml_doc.root.attributes['dob']
  end
  
  
  # Returns an array of all the appearances (Batting or Pitching) made by this player
  # for the season specified.
  def get_all_appearances(year)
    results = []
    appearances = []
    games = get_games_for_season(year)    
    games.each do |game|
      self.team == game.home_team_abbrev ? status = 'home' : status = 'away'
      if self.position == 'P'
        appearances.push *(game.get_pitchers(status))
      else
        appearances.push *(game.get_batters(status))
      end
    end
    # now go through all appearances to find those for this player
    appearances.each do |appearance|
      if appearance.pid == self.pid
       results << appearance
      end
    end
    results
  end
  
  
  # Returns an array of all the appearances (Batting or Pitching) made by this player
  # for the season specified, in which the player had more than 1 hit.
  def get_multihit_appearances(year)
    results = []
    appearances = []
    games = get_games_for_season(year)   
    games.each do |game|
      self.team == game.home_team_abbrev ? status = 'home' : status = 'away'
      if self.position == 'P'
        appearances.push *(game.get_pitchers(status))
      else
        appearances.push *(game.get_batters(status))
      end
    end
    # now go through all appearances to find those for this player
    appearances.each do |appearance|
      if appearance.pid == self.pid && appearance.h.to_i > 1
       results << appearance
      end
    end
    results
  end
  
  
  # Returns the number of at bats over the entire season for this player
  def at_bats_count
    gameday_info = GamedayUtili.parse_gameday_id(@gid)
    appearances = get_all_appearances(gameday_info["year"])
    count = 0
    appearances.each do |appear|
      count = count + appear.ab
    end
    count
  end
  
  
  # Returns the Team object representing the team for which this player plays
  def get_team
    if !@team_obj
      @team = Team.new(self.team)
    end
    @team_obj
  end
  
  
  # Returns an array of all the games for the team this player is on for the season specified
  # currently will not handle a player who has played for multiple teams over a season
  def get_games_for_season(year)
    if !@games
      @games = get_team.all_games(year)  
    end
    @games
  end
  
end
