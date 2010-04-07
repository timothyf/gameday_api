$: << File.expand_path(File.dirname(__FILE__) + "/../../lib")

require 'test/unit'
require 'batter'

class TestBatter < Test::Unit::TestCase
  
  
  def test_get_all_ids_for_game
    batters = Batter.get_all_ids_for_game('2009_09_20_detmlb_minmlb_1')
    assert_not_nil batters
    assert batters.length == 87
    assert batters[0] == "111851"
    assert batters[1] == "118158"
    assert batters[85] == "545363"
    assert batters[86] == "547820"
  end

end