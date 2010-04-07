$: << File.expand_path(File.dirname(__FILE__) + "/../../lib")

require 'test/unit'
require 'roster'

class TestRoster < Test::Unit::TestCase
  
  
  def test_find_player_by_last_name
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    rosters = game.get_rosters
    player = rosters[0].find_player_by_last_name('Verlander')
    assert_not_nil player
    assert player.first == 'Justin'
    assert player.last == 'Verlander'
  end
  
  
  def test_find_player_by_id
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    rosters = game.get_rosters
    player = rosters[0].find_player_by_id('425146')
    assert_not_nil player
    assert player.first == 'Nate'
    assert player.last == 'Robertson'
  end
  
end