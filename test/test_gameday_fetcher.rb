$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'test/unit'
require 'gameday_fetcher'

class TestGamedayFetcher < Test::Unit::TestCase
  
  def setup
    @gid = 'gid_2008_04_07_atlmlb_colmlb_1'    
  end
  
  
  def teardown
    
  end
  
  
  def test_fetch_bench
    bench = GamedayFetcher.fetch_bench(@gid)
    assert_not_nil bench
  end
  
  
  def test_fetch_bencho
    bencho = GamedayFetcher.fetch_bencho(@gid)
    assert_not_nil bencho  
  end
  
  
  def test_fetch_boxscore
    bs = GamedayFetcher.fetch_boxscore(@gid)
    assert_not_nil bs
  end
  
  
end