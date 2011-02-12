module Gameday
  class Hip
  
    attr_accessor :des, :x, :y, :batter_id, :pitcher_id, :type, :team, :inning
  
  
    def initialize(element)
      @des = element.attributes["des"]
      @des = element.attributes["x"]
      @des = element.attributes["y"]
      @des = element.attributes["batter"]
      @des = element.attributes["pitcher"]
      @des = element.attributes["type"]
      @des = element.attributes["team"]
      @des = element.attributes["inning"]
    end
  
  
  end
end