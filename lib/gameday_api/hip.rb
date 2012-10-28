module GamedayApi

  class Hip
  
    attr_accessor :des, :x, :y, :batter_id, :pitcher_id, :hip_type, :team, :inning
  
  
    def initialize(element)
      @des = element.attributes["des"]
      @x = element.attributes["x"]
      @y = element.attributes["y"]
      @batter_id = element.attributes["batter"]
      @pitcher_id = element.attributes["pitcher"]
      @hip_type = element.attributes["type"]
      @team = element.attributes["team"]
      @inning = element.attributes["inning"]
    end
  
  
  end
end