require 'pitch'


# This class represents a single atbat during a single game
class AtBat
  
  attr_accessor :gid, :inning, :away_team, :home_team
  attr_accessor :num, :b, :s, :o, :batter_id, :stand, :b_height, :pitcher_id, :p_throws, :des, :event
  attr_accessor :pitches
  
  def init(element, gid)
    @xml_doc = element
  	@gid = gid
	@num = element.attributes["num"]
	@b = element.attributes["b"]
	@s = element.attributes["s"]
	@o = element.attributes["o"]
	@batter_id = element.attributes["batter"]
	@stand = element.attributes["stand"]
	@b_height = element.attributes["b_height"]
	@pitcher_id = element.attributes["pitcher"]
	@p_throws = element.attributes["p_throws"]
	@des = element.attributes["des"]
	@event = element.attributes["event"]
	
	set_pitches
  end
  
  
  def set_pitches
  	@pitches = []
    @xml_doc.elements.each("atbat/pitch") do |element| 
    	pitch = Pitch.new
    	pitch.init(element)
    	@pitches << pitch
    end
  end
  
  
end
