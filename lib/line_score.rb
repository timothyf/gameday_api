
# This class contains data representing a linescore for a single game.
class LineScore
  
  attr_accessor :xml_doc
  attr_accessor :away_team_runs, :home_team_runs, :away_team_hits, :home_team_hits, :away_team_errors, :home_team_errors
  attr_accessor :innings
  
  # Initialize this instance from an XML element containing linescore data.
  def init(element)
  	@xml_doc = element
    self.away_team_runs = element.attributes["away_team_runs"]
    self.away_team_hits = element.attributes["away_team_hits"]
    self.away_team_errors = element.attributes["away_team_errors"]
      
    self.home_team_runs = element.attributes["home_team_runs"]
    self.home_team_hits = element.attributes["home_team_hits"]
    self.home_team_errors = element.attributes["home_team_errors"]
    
    # Set score by innings
    set_innings 
  end
  
  
  def set_innings 
    @innings = []
  	@xml_doc.elements.each("inning_line_score") do |element|
	    score = []
	    score.push element.attributes["away"]
	    score.push element.attributes["home"]
	    @innings.push score
	end
  end


  
end

