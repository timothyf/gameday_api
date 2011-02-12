$: << File.expand_path(File.dirname(__FILE__) + "/../../lib")

require 'test/unit'
require 'box_score'

class TestBoxScore < Test::Unit::TestCase
  
  
  def setup
  end


  def test_load_from_id
    bs = BoxScore.new
    bs.load_from_id('2009_09_20_detmlb_minmlb_1')
    assert_equal '2009_09_20_detmlb_minmlb_1', bs.gid
    assert_equal 11223, bs.xml_data.length
    assert_not_nil bs.linescore
    assert_not_nil bs.game_info
    assert_equal '2009/09/20/detmlb-minmlb-1', bs.game_id
    assert_equal '246422', bs.game_pk
    assert_equal 'mlb', bs.home_sport_code
    assert_equal 'det', bs.away_team_code
    assert_equal 'min', bs.home_team_code
    assert_equal '116', bs.away_id
    assert_equal '142', bs.home_id
    assert_equal 'Detroit Tigers', bs.away_fname
    assert_equal 'Minnesota Twins', bs.home_fname
    assert_equal 'Detroit', bs.away_sname
    assert_equal 'Minnesota', bs.home_sname
    assert_equal 'September 20, 2009', bs.date
    assert_equal '79', bs.away_wins
    assert_equal '70', bs.away_loss
    assert_equal '76', bs.home_wins
    assert_equal '73', bs.home_loss
    assert_equal 'F', bs.status_ind
    assert_equal '6', bs.away_runs
    assert_equal '2', bs.home_runs
    assert_nil bs.temp
    assert_nil bs.wind_speed
    assert_nil bs.wind_dir
    
    assert_equal 612, bs.home_batting_text.length
    assert_equal 698, bs.away_batting_text.length
    
    assert_equal 'Detroit', bs.cities[0]
    assert_equal 'Minnesota', bs.cities[1]
    
    assert_equal 2, bs.pitchers.length
    assert_equal 2, bs.batters.length
  end
  
  
  def test_to_html
    bs = BoxScore.new
    bs.load_from_id('2009_09_20_detmlb_minmlb_1')
    html = bs.to_html('boxscore.html.erb')
    assert_not_nil html
    puts 'length = ' + html.length.to_s
    #assert_equal 14916, html.length
  end
  
  
  def test_get_leadoff_hitters
    bs = BoxScore.new
    bs.load_from_id('2009_09_20_detmlb_minmlb_1')
    hitters = bs.get_leadoff_hitters
    assert_equal 2, hitters.length
    assert_equal 'Granderson', hitters[0].batter_name
    assert_equal 'Span', hitters[1].batter_name
  end
  
  
  def test_get_cleanup_hitters
    bs = BoxScore.new
    bs.load_from_id('2009_09_20_detmlb_minmlb_1')
    hitters = bs.get_cleanup_hitters
    assert_equal 2, hitters.length
    assert_equal 'Cabrera, M', hitters[0].batter_name
    assert_equal 'Kubel', hitters[1].batter_name
  end
  
  
  def test_find_hitters
    
  end


end