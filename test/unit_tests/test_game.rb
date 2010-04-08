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
    games = Game.find_by_date('2009', '9', '20')
    assert_not_nil games
    assert games.length == 16
  end
  
  
  def test_find_by_month
    games = Game.find_by_month('2009', '9')
    assert_not_nil games
    assert games.length == 438
  end
  
  
  def test_get_innings
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    innings = game.get_innings
    assert innings.length == 9
    
    game = Game.new('2009_05_02_kcamlb_minmlb_1')
    innings = game.get_innings
    assert innings.length == 11
  end
  
  
  def test_get_atbats
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    atbats = game.get_atbats
    assert_not_nil atbats
    assert atbats.length == 81
  end
  
  
  def test_get_hitchart
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    hitchart = game.get_hitchart
    assert_not_nil hitchart
    assert hitchart.hips.length == 57
  end
  
  
  def test_get_num_innings
    game = Game.new('2008_04_07_atlmlb_colmlb_1')
    assert game.get_num_innings == 9
    
    game = Game.new('2009_05_02_kcamlb_minmlb_1')
    assert game.get_num_innings == 11
  end
  
  
end