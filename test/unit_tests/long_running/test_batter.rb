$: << File.expand_path(File.dirname(__FILE__) + "/../../../lib")

require 'test/unit'
require 'batter'

class TestBatter < Test::Unit::TestCase
  
  
  def setup
    if !@batter
      @batter = Batter.new
      @batter.load_from_id('2009_09_20_detmlb_minmlb_1', '434158')
    end
  end
  
 
  def test_long_running
    get_multihit_appearances_test
    #at_bats_count_test
  end
  
  
  def get_multihit_appearances_test
    appearances = @batter.get_multihit_appearances('2009')
    assert_not_nil appearances
    assert appearances.length == 40
  end
  
  
  def at_bats_count_test
    ab_count = @batter.at_bats_count
    assert ab_count == 631
  end
  
  
end