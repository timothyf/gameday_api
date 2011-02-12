$: << File.expand_path(File.dirname(__FILE__) + "/../../lib")

require 'test/unit'
require 'gameday_fetcher'

class TestGamedayFetcher < Test::Unit::TestCase
  
  
  def setup

  end
  
  
  def test_fetch_bench
    result = Gameday::GamedayFetcher.fetch_bench('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>')
  end
  
  
  def test_fetch_bench_returning_404
    result = Gameday::GamedayFetcher.fetch_bench('2010_04_05_nyamlb_bosmlb_1')
    assert_nil result
  end
  
  
  def test_fetch_bencho
    result = Gameday::GamedayFetcher.fetch_bencho('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('Copyright 2009 MLB Advanced Media, L.P.  Use of any content on this page')
  end
  
  
  def test_fetch_boxscore
    result = Gameday::GamedayFetcher.fetch_boxscore('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('Copyright 2009 MLB Advanced Media, L.P.  Use of any content on this page')
  end
  
  
  def test_fetch_emailsource
    result = Gameday::GamedayFetcher.fetch_emailsource('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('Copyright 2009 MLB Advanced Media, L.P.  Use of any content on this page')
  end
  
  
  def test_fetch_eventlog
    result = Gameday::GamedayFetcher.fetch_eventlog('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('Copyright 2009 MLB Advanced Media, L.P.  Use of any content on this page')
  end
  
  
  def test_fetch_game_xml
    result = Gameday::GamedayFetcher.fetch_game_xml('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('Copyright 2009 MLB Advanced Media, L.P.  Use of any content on this page')
    assert result.include?('<game type="R" local_game_time="13:10" gameday_sw="E">')
  end
  
  
  def test_fetch_gamecenter_xml
    result = Gameday::GamedayFetcher.fetch_gamecenter_xml('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('<game status="F" id="2009_09_20_detmlb_minmlb_1" start_time="2:10" ampm="pm" time_zone="ET"')
  end
  
  
  def test_fetch_gamedaysyn
    result = Gameday::GamedayFetcher.fetch_gamedaysyn('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('Copyright 2009 MLB Advanced Media, L.P.  Use of any content on this page')
  end
  
  
  def test_fetch_linescore
    result = Gameday::GamedayFetcher.fetch_linescore('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('<?xml version="1.0" encoding="UTF-8"?>')
  end
  
  
  def test_fetch_miniscoreboard
    result = Gameday::GamedayFetcher.fetch_miniscoreboard('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('Copyright 2009 MLB Advanced Media, L.P.  Use of any content on this page')
  end
  
  
  def test_fetch_players
    result = Gameday::GamedayFetcher.fetch_players('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('Copyright 2009 MLB Advanced Media, L.P.  Use of any content on this page')
  end
  
  
  def test_fetch_plays
    result = Gameday::GamedayFetcher.fetch_plays('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('Copyright 2009 MLB Advanced Media, L.P.  Use of any content on this page')
  end
  
  
  def test_fetch_scoreboard
    result = Gameday::GamedayFetcher.fetch_scoreboard('2009', '9', '20')
    assert_not_nil result
    assert result.include?('<?xml version="1.0" encoding="UTF-8"?>')
  end
  
  
  def test_fetch_batter
    result = Gameday::GamedayFetcher.fetch_batter('2009_09_20_detmlb_minmlb_1', '276346')
    assert_not_nil result
    assert result.include?('Copyright 2009 MLB Advanced Media, L.P.  Use of any content on this page')
    assert result.include?('first_name="Brandon" last_name="Inge"')
  end
  
  
  def test_fetch_pitcher
    result = Gameday::GamedayFetcher.fetch_pitcher('2009_09_20_detmlb_minmlb_1', '150144')
    assert_not_nil result
    assert result.include?('Copyright 2009 MLB Advanced Media, L.P.  Use of any content on this page')
    assert result.include?('first_name="Bobby" last_name="Seay"')
  end
  
  
  def test_fetch_inningx
    result = Gameday::GamedayFetcher.fetch_inningx('2009_09_20_detmlb_minmlb_1', 3)
    assert_not_nil result
    assert result.include?('Copyright 2009 MLB Advanced Media, L.P.  Use of any content on this page')
    assert result.include?('<inning num="3" away_team="det"')
  end
  
  
  def test_fetch_inning_scores
    result = Gameday::GamedayFetcher.fetch_inning_scores('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('Copyright 2009 MLB Advanced Media, L.P.  Use of any content on this page')
    assert result.include?('Jason Kubel grounds out, second baseman Placido Polanco to first')
  end
  
  
  def test_fetch_inning_hit
    result = Gameday::GamedayFetcher.fetch_inning_hit('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('Copyright 2009 MLB Advanced Media, L.P.  Use of any content on this page')
    assert result.include?('<hip des="Error" x="71.29" y="122.49" batter="135784"')
  end
 
 
  def test_fetch_games_page
    result = Gameday::GamedayFetcher.fetch_games_page('2009', '9', '20')
    assert_not_nil result
    assert result.include?('<h1>Index of /components/game/mlb/year_2009/month_09/day_20</h1>')
  end
  
  
  def test_fetch_batters_page
    result = Gameday::GamedayFetcher.fetch_batters_page('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('<h1>Index of /components/game/mlb/year_2009/month_09/day_20/')
    assert result.include?('<li><a href="111851.xml"> 111851.xml</a></li>')
  end
  
  
  def test_fetch_pitchers_page
    result = Gameday::GamedayFetcher.fetch_pitchers_page('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('<h1>Index of /components/game/mlb/year_2009/month_09/day_20/')
    assert result.include?('<li><a href="150274.xml"> 150274.xml</a></li>')
  end
  
  
  def test_fetch_media_highlights
    result = Gameday::GamedayFetcher.fetch_media_highlights('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('<media type="video" date="2009-09-20T15:30:27-0400" id="6751897" v="3">')
  end
  
  
  def test_fetch_media_mobile
    result = Gameday::GamedayFetcher.fetch_media_mobile('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('<media id="6748565" date="2009-09-20T14:30:24-0400" type="video" top-play="true">')
  end
  
  
  def test_fetch_onbase_linescore
    result = Gameday::GamedayFetcher.fetch_onbase_linescore('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('<away i1="0" i2="0" i3="0" i4="1" i5="3" i6="0" i7="0" i8="2" i9="0"/>')
  end
  
  
  def test_fetch_onbase_plays
    result = Gameday::GamedayFetcher.fetch_onbase_plays('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('<who p="407845" era="3.82" b="346857" avg=".227" b1="445196" b2="" b3=""/>')
  end
  
  
  def test_fetch_notifications_inning
    result = Gameday::GamedayFetcher.fetch_notifications_inning('2009_09_20_detmlb_minmlb_1', 3)
    assert_not_nil result
    assert result.include?('<notification inning="3" top="N" ab="25" pitch="0" seq="1" away_team_runs="0"')
  end
  
  
  def test_fetch_notifications_full
    result = Gameday::GamedayFetcher.fetch_notifications_full('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('<notifications modified_date="2009-09-28T15:50:23Z">')
  end
  
  
  
end