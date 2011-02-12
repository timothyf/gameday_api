$: << File.expand_path(File.dirname(__FILE__) + "/../../lib")

require 'test/unit'
require 'gameday_url_builder'

class TestGamedayUrlBuilder < Test::Unit::TestCase
  
  
  def setup

  end
  

  def test_build_eventlog_url
    url = Gameday::GamedayUrlBuilder.build_eventlog_url('2009', '9', '20', '2009_09_20_detmlb_minmlb_1')
    assert_not_nil url
    assert_equal "http://gd2.mlb.com/components/game/mlb/year_2009/month_09/day_20/gid_2009_09_20_detmlb_minmlb_1/eventLog.xml" , url
  end
  
  
  def test_build_scoreboard_url
    url = Gameday::GamedayUrlBuilder.build_scoreboard_url('2009', '9', '20')
    assert_not_nil url
    assert_equal 'http://gd2.mlb.com/components/game/mlb/year_2009/month_09/day_20/master_scoreboard.xml' , url
  end
  
  
  def test_build_boxscore_url
    url = Gameday::GamedayUrlBuilder.build_boxscore_url('2009', '9', '20', '2009_09_20_detmlb_minmlb_1')
    assert_not_nil url
    assert_equal "http://gd2.mlb.com/components/game/mlb/year_2009/month_09/day_20/gid_2009_09_20_detmlb_minmlb_1/boxscore.xml" , url
  end
  
  
  def test_build_game_url
    url = Gameday::GamedayUrlBuilder.build_game_url('2009', '9', '20', '2009_09_20_detmlb_minmlb_1')
    assert_not_nil url
    assert_equal "http://gd2.mlb.com/components/game/mlb/year_2009/month_09/day_20/gid_2009_09_20_detmlb_minmlb_1/game.xml" , url
  end
  
  
  def test_build_gamecenter_url
    url = Gameday::GamedayUrlBuilder.build_gamecenter_url('2009', '9', '20', '2009_09_20_detmlb_minmlb_1')
    assert_not_nil url
    assert_equal "http://gd2.mlb.com/components/game/mlb/year_2009/month_09/day_20/gid_2009_09_20_detmlb_minmlb_1/gamecenter.xml" , url
  end
  
  
  def test_build_linescore_url
    url = Gameday::GamedayUrlBuilder.build_linescore_url('2009', '9', '20', '2009_09_20_detmlb_minmlb_1')
    assert_not_nil url
    assert_equal "http://gd2.mlb.com/components/game/mlb/year_2009/month_09/day_20/gid_2009_09_20_detmlb_minmlb_1/linescore.xml" , url
  end
  
  
  def test_build_players_url
    url = Gameday::GamedayUrlBuilder.build_players_url('2009', '9', '20', '2009_09_20_detmlb_minmlb_1')
    assert_not_nil url
    assert_equal "http://gd2.mlb.com/components/game/mlb/year_2009/month_09/day_20/gid_2009_09_20_detmlb_minmlb_1/players.xml" , url
  end
  
  
  def test_build_batter_url
    url = Gameday::GamedayUrlBuilder.build_batter_url('2009', '9', '20', '2009_09_20_detmlb_minmlb_1','12345')
    assert_not_nil url
    assert_equal "http://gd2.mlb.com/components/game/mlb/year_2009/month_09/day_20/gid_2009_09_20_detmlb_minmlb_1/batters/12345.xml" , url
  end
  
  
  def test_build_pitcher_url
    url = Gameday::GamedayUrlBuilder.build_pitcher_url('2009', '9', '20', '2009_09_20_detmlb_minmlb_1','12345')
    assert_not_nil url
    assert_equal "http://gd2.mlb.com/components/game/mlb/year_2009/month_09/day_20/gid_2009_09_20_detmlb_minmlb_1/pitchers/12345.xml" , url
  end
  
  
  def test_build_pbp_inningx_url
    url = Gameday::GamedayUrlBuilder.build_inningx_url('2009', '9', '20', '2009_09_20_detmlb_minmlb_1','3')
    assert_not_nil url
    assert_equal "http://gd2.mlb.com/components/game/mlb/year_2009/month_09/day_20/gid_2009_09_20_detmlb_minmlb_1/inning/inning_3.xml" , url
  end
  
  
  def test_build_pbp_inning_scores_url
    url = Gameday::GamedayUrlBuilder.build_inning_scores_url('2009', '9', '20', '2009_09_20_detmlb_minmlb_1')
    assert_not_nil url
    assert_equal "http://gd2.mlb.com/components/game/mlb/year_2009/month_09/day_20/gid_2009_09_20_detmlb_minmlb_1/inning/inning_Scores.xml" , url
  end
  
  
  def test_build_pbp_inning_hit_url
    url = Gameday::GamedayUrlBuilder.build_inning_hit_url('2009', '9', '20', '2009_09_20_detmlb_minmlb_1')
    assert_not_nil url
    assert_equal "http://gd2.mlb.com/components/game/mlb/year_2009/month_09/day_20/gid_2009_09_20_detmlb_minmlb_1/inning/inning_hit.xml" , url
  end
  
  
  def test_build_day_url
    url = Gameday::GamedayUrlBuilder.build_day_url('2009', '9', '20')
    assert_not_nil url
    assert_equal "http://gd2.mlb.com/components/game/mlb/year_2009/month_09/day_20/" , url
  end
  
  
end