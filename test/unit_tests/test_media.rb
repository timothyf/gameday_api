$: << File.expand_path(File.dirname(__FILE__) + "/../../lib")

require 'test/unit'
require 'media'

class TestTeam < Test::Unit::TestCase
  
  
  def test_load_from_id
    media = Gameday::Media.new
    media.load_from_id('2009_09_20_detmlb_minmlb_1')
    assert_not_nil media.highlights
    assert_not_nil media.mobile
    assert_equal 6, media.highlights.length
    assert_equal "Punto's RBI single", media.highlights[0].headline
    assert_equal "00:00:37", media.highlights[0].duration
    assert_equal "http://mediadownloads.mlb.com/mlbam/2009/09/20/rth_6751897_th_7.jpg", media.highlights[0].thumb_url
    assert_equal "http://mediadownloads.mlb.com/mlbam/2009/09/20/mlbtv_detmin_6751897_400K.mp4", media.highlights[0].res_400_url
    assert_equal "http://mediadownloads.mlb.com/mlbam/2009/09/20/rth_detmin_6751897_500.mp4", media.highlights[0].res_500_url
    assert_equal "http://mediadownloads.mlb.com/mlbam/2009/09/20/mlbtv_detmin_6751897_800K.mp4", media.highlights[0].res_800_url
  end
  
  
end