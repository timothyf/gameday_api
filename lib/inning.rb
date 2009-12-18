require 'at_bat'


# This class represents a single inning of an MLB game
class Inning
  
  attr_accessor :gid, :num, :away_team, :home_team, :atbats
  
  
  def init(element, gid)
    @atbats = []
    @gid = gid
    @num = element.attributes['num']
    @away_team = element.attributes['away_team']
    @home_team = element.attributes['home_team']
    setup_atbats
  end
  
  
  def setup_atbats
    atbats.each do |atbat|
      atbat = AtBat.new
      atbat.init()
      @atbats << atbat
    end
  end
  
  
end