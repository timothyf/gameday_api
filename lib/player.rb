# This class represents a single MLB player from a single MLB game
class Player
  
  # attributes from players.xml
  attr_accessor :gid, :pid, :first, :last, :num, :boxname, :rl, :position, :status, :bat_order, :game_position 
  attr_accessor :avg, :hr, :std_hr, :rbi, :wins, :losses, :era, :saves, :team_code
  
  # attributes from batters/13353333.xml or pitchers/1222112.xml
  attr_accessor :team, :type, :height, :weight, :bats, :throws, :dob
    
  # object pointers
  attr_accessor :team_obj, :games, :appearances
  
  
  # Initializes a Player object by reading the player data from the players.xml file for the player specified by game id and player id.
  def load_from_id(gid, pid)
    @gid = gid
    @pid = pid
    # fetch players.xml file
    xml_doc = GamedayFetcher.fetch_players(gid)
    # find specific player in the file
    pelement = xml_doc.root.elements["team/player[@id=#{pid}]"]
    init(pelement, gid)
  end
  
  
  # Initialize a player object by reading data from the players.xml file
  def init(element, gid)
    @gid = gid
    @pid = element.attributes['id']
    @first = element.attributes['first']
    @last = element.attributes['last']
    @num= element.attributes['num']
    @boxname = element.attributes['boxname']
    @rl, = element.attributes['rl']
    @position = element.attributes['position']
    @status = element.attributes['status']
    @bat_order = element.attributes['bat_order']
    @game_position = element.attributes['game_position']
    @avg = element.attributes['avg']
    @hr = element.attributes['hr']
    @rbi = element.attributes['rbi']
    @wins = element.attributes['wins']
    @losses = element.attributes['losses']
    @era = element.attributes['era'] 
      
    set_extra_info
  end
  
  
  # Initializes pitcher info from data read from the masterscoreboard.xml file
  def init_pitcher_from_scoreboard(element)
    @first = element.attributes['first']
    @last = element.attributes['last']
    @wins = element.attributes['wins']
    @losses = element.attributes['losses']
    @era = element.attributes['era']
  end
    
  
  # Set data that is read from the batter or pitcher file found in the batters/xxxxxxx.xml file or pitchers/xxxxxx.xml file
  def set_extra_info
    if @position == 'P'
      xml_data = GamedayFetcher.fetch_pitcher(@gid, @pid)
    else
      xml_data = GamedayFetcher.fetch_batter(@gid, @pid)
    end
    xml_doc = REXML::Document.new(xml_data)
    @team = xml_doc.root.attributes['team']
    @type = xml_doc.root.attributes['type']
    @height = xml_doc.root.attributes['height']
    @weight = xml_doc.root.attributes['weight']
    @bats = xml_doc.root.attributes['bats']
    @throws = xml_doc.root.attributes['throws']
    @dob = xml_doc.root.attributes['dob']
  end
  
  
  # Returns an array of all the appearances (Batting or Pitching) made by this player
  # for the season specified.
  def get_all_appearances(year)
    results = []
    appearances = []
    games = get_games_for_season(year)    
    games.each do |game|
      @team == game.home_team_abbrev ? status = 'home' : status = 'away'
      if @position == 'P'
        appearances.push *(game.get_pitchers(status))
      else
        appearances.push *(game.get_batters(status))
      end
    end
    # now go through all appearances to find those for this player
    appearances.each do |appearance|
      if appearance.pid == @pid
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
      @team == game.home_team_abbrev ? status = 'home' : status = 'away'
      if @position == 'P'
        appearances.push *(game.get_pitchers(status))
      else
        appearances.push *(game.get_batters(status))
      end
    end
    # now go through all appearances to find those for this player
    appearances.each do |appearance|
      if appearance.pid == @pid && appearance.h.to_i > 1
       results << appearance
      end
    end
    results
  end
  
  
  # Returns the number of at bats over the entire season for this player
  def at_bats_count
    gameday_info = GamedayUtili.parse_gameday_id(@gid)
    appearances = get_all_appearances(gameday_info["year"])
    count = appearances.inject(0) {|sum, a| sum + a.ab }    
  end
  
  
  # Returns the Team object representing the team for which this player plays
  def get_team
    if !@team_obj
      @team_obj = Team.new(@team)
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
