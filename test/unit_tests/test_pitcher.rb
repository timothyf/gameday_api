$: << File.expand_path(File.dirname(__FILE__) + "/../../lib")

require 'test/unit'
require 'pitcher'

class TestPitcher < Test::Unit::TestCase
  
  
  def test_get_all_ids_for_game
    ids = Pitcher.get_all_ids_for_game('2009_09_20_detmlb_minmlb_1')
    assert_not_nil ids
    assert ids.length == 41
    assert ids[0] == "118158"
    assert ids[1] == "132220"
    assert ids[39] == "545363"
    assert ids[40] == "547820"
  end

end