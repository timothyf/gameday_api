$: << File.expand_path(File.dirname(__FILE__) + "/../../lib")

require 'test/unit'
require 'gameday_util'

class TestGamedayUtil < Test::Unit::TestCase
  
  
  def test_parse_date_string
    date = '20100401'
    result = GamedayUtil.parse_date_string(date)
    assert_not_nil result
    assert result[0] == '2010'
    assert result[1] == '04'
    assert result[2] == '01' 
  end
  
  
  def test_convert_digit_to_string
    result = GamedayUtil.convert_digit_to_string(8)
    assert result == '08'
    
    result = GamedayUtil.convert_digit_to_string(0)
    assert result == '00'
    
    result = GamedayUtil.convert_digit_to_string(12)
    assert result == '12'
  end
  
  
  def test_parse_gameday_id
    gid = 'gid_2008_04_07_atlmlb_colmlb_1'
    gd_info = GamedayUtil.parse_gameday_id(gid)
    assert_not_nil gd_info
    assert gd_info["year"] == '2008'
    assert gd_info["month"] == '04'
    assert gd_info["day"] == '07'
    assert gd_info['visiting_team_abbrev'] == 'atl'
    assert gd_info['home_team_abbrev'] == 'col'
    assert gd_info['game_number'] == '1'
  end
  
  
  def test_read_config
    GamedayUtil.read_config
  end
  
  
  def test_get_connection
    url = 'http://www.google.com'
    con = GamedayUtil.get_connection(url)
    assert_not_nil con
  end
  
  
  def test_net_http
    result = GamedayUtil.net_http
    assert_not_nil result
  end
  
  
  def test_save_file
    filename = 'test_file.dat'
    data = 'Test Data'
    GamedayUtil.save_file(filename, data)
  end
  
  
  def test_is_date_valid
    assert !GamedayUtil.is_date_valid(4, 31)
    assert !GamedayUtil.is_date_valid(6, 31)
    assert !GamedayUtil.is_date_valid(9, 31)
    assert !GamedayUtil.is_date_valid(04, 1)
    assert !GamedayUtil.is_date_valid(04, 4)
    assert GamedayUtil.is_date_valid(04, 5)
  end
  
  
end
