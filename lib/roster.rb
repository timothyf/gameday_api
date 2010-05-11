require 'player'
require 'coach'


# This class represents a team's roster for a single game.
# Both players and coaches can be read from the roster.
class Roster
  
  attr_accessor :gid, :id, :team_name, :type, :players, :coaches
  # type = home or away
  
  def init(element, gid)
    self.gid = gid
    self.team_name = element.attributes['name']
    self.id = element.attributes['id']
    self.type = element.attributes['type']
    self.players = []
    self.coaches = []
    self.set_players(element)
    self.set_coaches(element)
  end
  
  
  def find_player_by_last_name(last_name)
    players.each do |player|
      if player.last == last_name
        return player
      end
    end
    nil
  end
  
  
  def find_player_by_id(pid)
    players.each do |player|
      if player.pid == pid
        return player
      end
    end
    nil
  end
  
  
  def set_players(element)
    element.elements.each("player") { |element|
      player = Player.new
      player.init(element, gid)
      @players << player
    }
  end
  
  
  def set_coaches(element)
    element.elements.each("coach") { |element|
      coach = Coach.new
      coach.init(element)
      self.coaches << coach
    }
  end
  
end