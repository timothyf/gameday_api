require 'gameday_api/gameday_fetcher'

module GamedayApi

  class Scoreboard
  
    attr_accessor :games  # An array of Game objects representing all of the games played on this date
    attr_accessor :year, :month, :day
  
    def load_for_date(year, month, day)
      @games = []
      @year = year
      @month = month
      @day = day
      @xml_data = GamedayFetcher.fetch_scoreboard(year, month, day)
      @xml_doc = REXML::Document.new(@xml_data)
    
      @xml_doc.elements.each("games/game") { |element|
        game = Game.new(element.attributes['gameday'])
        game.load_from_scoreboard(element)
        @games << game
      }
    end
  
  end
end