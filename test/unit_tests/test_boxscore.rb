$: << File.expand_path(File.dirname(__FILE__) + "/../../lib")

require 'test/unit'
require 'box_score'

class TestBoxScore < Test::Unit::TestCase
  
  
  def setup
  end


  def test_load_from_id
    bs = BoxScore.new
    bs.load_from_id('2009_09_20_detmlb_minmlb_1')
    assert bs.gid == '2009_09_20_detmlb_minmlb_1'
    assert bs.xml_data.length == 11223
    assert_not_nil bs.linescore
    assert_not_nil bs.game_info
    assert bs.game_id == '2009/09/20/detmlb-minmlb-1'
    assert bs.game_pk == '246422'
    assert bs.home_sport_code == 'mlb'
    assert bs.away_team_code == 'det'
    assert bs.home_team_code == 'min'
    assert bs.away_id == '116'
    assert bs.home_id == '142'
    assert bs.away_fname == 'Detroit Tigers'
    assert bs.home_fname == 'Minnesota Twins'
    assert bs.away_sname == 'Detroit'
    assert bs.home_sname == 'Minnesota'
    assert bs.date == 'September 20, 2009'
    assert bs.away_wins == '79'
    assert bs.away_loss == '70'
    assert bs.home_wins == '76'
    assert bs.home_loss == '73'
    assert bs.status_ind == 'F'
    
    assert bs.home_batting_text.length == 612
    assert bs.away_batting_text.length == 698
    
    assert bs.cities[0] == 'Detroit'
    assert bs.cities[1] == 'Minnesota'
    
    assert bs.pitchers.length == 2
    assert bs.batters.length == 2
  end
  
  
  def test_to_html
    bs = BoxScore.new
    bs.load_from_id('2009_09_20_detmlb_minmlb_1')
    html = bs.to_html('boxscore.html.erb')
    assert_not_nil html
    assert html.length == 14916
  end
  
  
  def test_get_leadoff_hitters
    bs = BoxScore.new
    bs.load_from_id('2009_09_20_detmlb_minmlb_1')
    hitters = bs.get_leadoff_hitters
    assert hitters.length == 2
    assert hitters[0].batter_name == 'Granderson'
    assert hitters[1].batter_name == 'Span'
  end
  
  
  def test_get_cleanup_hitters
    bs = BoxScore.new
    bs.load_from_id('2009_09_20_detmlb_minmlb_1')
    hitters = bs.get_cleanup_hitters
    assert hitters.length == 2
    assert hitters[0].batter_name == 'Cabrera, M'
    assert hitters[1].batter_name == 'Kubel'
  end
  
  
  def test_find_hitters
    
  end


end