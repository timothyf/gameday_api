$: << File.expand_path(File.dirname(__FILE__) + "/../../lib")

require 'test/unit'
require 'inning'

class TestInning < Test::Unit::TestCase
  
  
  def test_load_from_id
    inning = Inning.new
    inning.load_from_id(get_gid, 3)
    assert inning.gid == get_gid
    assert inning.num == '3'
    assert inning.away_team == 'det'
    assert inning.home_team == 'min'
    assert inning.top_atbats.length == 4
    assert inning.bottom_atbats.length == 4
    assert inning.top_atbats[0].pitches.length == 4
    assert inning.top_atbats[1].pitches.length == 1
    assert inning.top_atbats[0].pitches[0].des == 'Foul'
    assert inning.top_atbats[0].pitches[0].id == '151'
    assert inning.top_atbats[0].pitches[0].type == 'S'
    assert inning.top_atbats[0].pitches[0].x == '90.13'
  end
  
  
  private 
  
  def get_gid
    '2009_09_20_detmlb_minmlb_1'
  end
  
  
end