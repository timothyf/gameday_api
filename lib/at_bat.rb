
# This class represents a single atbat during a single game
class AtBat
  
  attr_accessor :gid, :inning, :away_team, :home_team
  attr_accessor :num, :b, :s, :o, :batter_id, :stand, :b_height, :pitcher_id, :p_throws, :des, :event
  attr_accessor :pitches
  
  def init(element, gid)
    self.pitches = []
    
  end
  
  
  def set_pitches
    
  end
  
  
end

