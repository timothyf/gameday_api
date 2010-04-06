$: << File.expand_path(File.dirname(__FILE__) + "/../../lib")

require 'test/unit'
require 'player'

class TestPlayer < Test::Unit::TestCase
  
  
  def test_load_from_id
    player = Player.new
    player.load_from_id('2009_09_20_detmlb_minmlb_1', '434158')
    
    assert player.gid == '2009_09_20_detmlb_minmlb_1'
    assert player.pid == '434158'
    assert player.first == 'Curtis'
    assert player.last == 'Granderson'
    assert player.num == '28'
    assert player.boxname == 'Granderson'
    assert player.rl == 'R'
    assert player.position == 'CF'
    assert player.status == 'A'
    assert player.bat_order == '1'
    assert player.game_position == 'CF'
    assert player.avg == '.250'
    assert player.hr == '27'
    assert player.rbi == '63'
    assert player.wins == nil
    assert player.losses == nil
    assert player.era == nil
      
    assert player.team == 'det'
    assert player.type == 'batter'
    assert player.height == '6-1'
    assert player.weight == '185'
    assert player.bats == 'L'
    assert player.throws == 'R'
    assert player.dob == '03/16/1981'
  end


  def test_get_team
    player = Player.new
    player.load_from_id('2009_09_20_detmlb_minmlb_1', '434158')
    team = player.get_team
    assert_not_nil team
    assert team.city == 'Detroit'
    assert team.name == 'Tigers'
  end
  

end