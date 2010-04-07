$: << File.expand_path(File.dirname(__FILE__) + "/../../lib")

require 'test/unit'
require 'media'

class TestTeam < Test::Unit::TestCase
  
  
  def test_load_from_id
    media = Media.new
    media.load_from_id('2009_09_20_detmlb_minmlb_1')
    assert_not_nil media.highlights
    assert_not_nil media.mobile
    assert media.highlights.length == 6
    assert media.highlights[0].headline == "Punto's RBI single"
    assert media.highlights[0].duration == "00:00:37"
    assert media.highlights[0].thumb_url == "http://mediadownloads.mlb.com/mlbam/2009/09/20/rth_6751897_th_7.jpg"
    assert media.highlights[0].res_400_url == "http://mediadownloads.mlb.com/mlbam/2009/09/20/mlbtv_detmin_6751897_400K.mp4"
    assert media.highlights[0].res_500_url == "http://mediadownloads.mlb.com/mlbam/2009/09/20/rth_detmin_6751897_500.mp4"
    assert media.highlights[0].res_800_url == "http://mediadownloads.mlb.com/mlbam/2009/09/20/mlbtv_detmin_6751897_800K.mp4"
  end
  
  
end