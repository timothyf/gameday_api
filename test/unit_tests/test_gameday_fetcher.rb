$: << File.expand_path(File.dirname(__FILE__) + "/../../lib")

require 'test/unit'
require 'gameday_fetcher'

class TestGamedayFetcher < Test::Unit::TestCase
  
  
  def setup

  end
  
  
  def test_fetch_bench
    result = GamedayFetcher.fetch_bench('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>')
  end
  
  
  def test_fetch_bencho
    result = GamedayFetcher.fetch_bencho('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('Copyright 2009 MLB Advanced Media, L.P.  Use of any content on this page')
  end
  
  
  def test_fetch_boxscore
    result = GamedayFetcher.fetch_boxscore('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('Copyright 2009 MLB Advanced Media, L.P.  Use of any content on this page')
  end
  
  
  def test_fetch_emailsource
    result = GamedayFetcher.fetch_emailsource('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('Copyright 2009 MLB Advanced Media, L.P.  Use of any content on this page')
  end
  
  
  def test_fetch_eventlog
    result = GamedayFetcher.fetch_eventlog('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('Copyright 2009 MLB Advanced Media, L.P.  Use of any content on this page')
  end
  
  
  def test_fetch_game_xml
    result = GamedayFetcher.fetch_game_xml('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('Copyright 2009 MLB Advanced Media, L.P.  Use of any content on this page')
    assert result.include?('<game type="R" local_game_time="13:10" gameday_sw="E">')
  end
  
  
  def test_fetch_gamecenter_xml
    result = GamedayFetcher.fetch_gamecenter_xml('2009_09_20_detmlb_minmlb_1')
    assert_not_nil result
    assert result.include?('<game status="F" id="2009_09_20_detmlb_minmlb_1" start_time="2:10" ampm="pm" time_zone="ET"')
  end
  
  
end