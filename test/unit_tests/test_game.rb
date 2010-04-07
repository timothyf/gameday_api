$: << File.expand_path(File.dirname(__FILE__) + "/../../lib")

require 'test/unit'
require 'game'

class TestGame < Test::Unit::TestCase
  
  
  def setup

  end
  
  
  def test_initialize
    gid = '2008_04_07_atlmlb_colmlb_1'
    game = Game.new(gid)
    assert_not_nil game
    assert game.gid == '2008_04_07_atlmlb_colmlb_1'
    assert game.home_team_abbrev == 'col'
    assert game.visit_team_abbrev == 'atl'
    assert game.visiting_team.abrev == 'atl'
    assert game.home_team.abrev == 'col'
    assert game.year == '2008'
    assert game.month == '04'
    assert game.day == '07'
    assert game.game_number == '1'
    assert game.home_team_name == 'Colorado'
    assert game.visit_team_name == 'Atlanta'
  end
  
  
  def test_find_by_date
    game = Game.find_by_date('2009', '9', '20')
    assert_not_nil game
  end
  
  
  def test_get_innings
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    innings = game.get_innings
    assert innings.length == 9
    
    game = Game.new('2009_05_02_kcamlb_minmlb_1')
    innings = game.get_innings
    assert innings.length == 11
  end
  
  
  def test_get_num_innings
    gid = '2008_04_07_atlmlb_colmlb_1'
    game = Game.new(gid)
    assert game.get_num_innings == 9
    
    gid = '2009_05_02_kcamlb_minmlb_1'
    game = Game.new(gid)
    assert game.get_num_innings == 11
  end
  
  
end