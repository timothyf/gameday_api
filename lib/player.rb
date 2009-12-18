# This class represents a single MLB player from a single MLB game
class Player
  
  # attributes from players.xml
  attr_accessor :gid, :id, :first, :last, :num, :boxname, :rl, :position, :status, :bat_order, :game_position, :avg, :hr, :rbi, :wins, :losses, :era
  
  # attributes from batters/13353333.xml or pitchers/1222112.xml
  attr_accessor :team, :type, :height, :weight, :bats, :throws, :dob
  
  
  # Initializes a Player object by reading the player data from the players.xml file for the player specified by game id and player id.
  def load_from_id(gid, pid)
    self.gid = gid
    self.id = pid
    # fetch players.xml file
    xml_doc = GamedayFetcher.fetch_players(gid)
    # find specific player in the file
    pelement = xml_doc.root.elements["team/player[@id=#{pid}]"]
    self.init(pelement, gid)
  end
  
  
  # Initialize a player object by reading data from the players.xml file
  def init(element, gid)
    self.gid = gid
    self.id = element.attributes['id']
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
      xml_data = GamedayFetcher.fetch_pitcher(self.gid, self.id)
    else
      xml_data = GamedayFetcher.fetch_batter(self.gid, self.id)
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
  
end
