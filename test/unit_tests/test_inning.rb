$: << File.expand_path(File.dirname(__FILE__) + "/../../lib")

require 'test/unit'
require 'inning'

class TestInning < Test::Unit::TestCase
  
  
  def test_load_from_id
    inning = Inning.new
    inning.load_from_id(get_gid, 3)
    assert_equal get_gid, inning.gid
    assert_equal '3', inning.num
    assert_equal 'det', inning.away_team
    assert_equal 'min', inning.home_team
    assert_equal 4, inning.top_atbats.length
    assert_equal 4, inning.bottom_atbats.length
    assert_equal 4, inning.top_atbats[0].pitches.length
    assert_equal 1, inning.top_atbats[1].pitches.length
    assert_equal 'Foul', inning.top_atbats[0].pitches[0].des
    assert_equal '151', inning.top_atbats[0].pitches[0].pitch_id
    assert_equal 'S', inning.top_atbats[0].pitches[0].type
    assert_equal '90.13', inning.top_atbats[0].pitches[0].x
  end
  
  
  private 
  
  def get_gid
    '2009_09_20_detmlb_minmlb_1'
  end
  
  
end