class Scoreboard
  
  @attr_accessor :games  # An array of Game objects representing all of the games played on this date
  
  
  def load_for_date(year, month, day)
    @xml_data = GamedayFetcher.fetch_scoreboard(year, month, day)
    @xml_doc = REXML::Document.new(@xml_data)
  end
  
end