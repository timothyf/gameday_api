$: << File.expand_path(File.dirname(__FILE__) + "/../../../lib")

require 'test/unit'
require 'player'

class TestPlayer < Test::Unit::TestCase
  

  def setup
    if !@player
      @player = Player.new
      @player.load_from_id('2009_09_20_detmlb_minmlb_1', '434158')
    end
  end
  
  
  def test_long_running
    get_all_appearances_test
    get_multihit_appearances_test
    at_bats_count_test
  end
  
  
  def get_all_appearances_test
    appearances = @player.get_all_appearances('2009')
    assert_not_nil appearances
    assert appearances.length == 160
  end
  
  
  def get_multihit_appearances_test
    appearances = @player.get_multihit_appearances('2009')
    assert_not_nil appearances
    assert appearances.length == 40
  end
  
  
  def at_bats_count_test
    ab_count = @player.at_bats_count
    assert ab_count == 631
  end

end