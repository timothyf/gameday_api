require 'at_bat'
require 'gameday_fetcher'


# This class represents a single inning of an MLB game
class Inning
  
  attr_accessor :gid, :num, :away_team, :home_team, :top_atbats, :bottom_atbats
  
  
  # loads an Inning object given a game id and an inning number
  def load_from_id(gid, inning)
    @top_atbats = []
    @bottom_atbats = []
    @gid = gid
    @xml_data = GamedayFetcher.fetch_inningx(gid, inning)
    @xml_doc = REXML::Document.new(@xml_data)
    if @xml_doc.root
      @num = @xml_doc.root.attributes["num"]
      @away_team = @xml_doc.root.attributes["away_team"]
      @home_team = @xml_doc.root.attributes["home_team"]
      set_top_ab
      set_bottom_ab
    end
  end
  
  
  private
  
  def set_top_ab
    @xml_doc.elements.each("inning/top/atbat") { |element| 
      atbat = AtBat.new
      atbat.init(element, @gid)
      @top_atbats.push atbat
    }
  end
  
  
  def set_bottom_ab
    @xml_doc.elements.each("inning/bottom/atbat") { |element| 
      atbat = AtBat.new
      atbat.init(element, @gid)
      @bottom_atbats.push atbat
    }
  end
  
  
end