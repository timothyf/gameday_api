module GamedayApi
  class Event
  
    attr_accessor :number, :inning, :description, :team
  
    def load(element, home_or_away)
    	@xml_doc = element
    	@team = home_or_away
      @number = element.attributes["number"]
      @inning = element.attributes["inning"]
      @description = element.attributes["description"]
    end
  
  
  end
end