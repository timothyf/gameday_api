$: << File.expand_path(File.dirname(__FILE__) + "/../../lib")

require 'test/unit'
require 'gameday_util'

class TestGamedayUtil < Test::Unit::TestCase
  
  
  def test_parse_date_string
    date = '20100401'
    result = GamedayUtil.parse_date_string(date)
    assert_not_nil result
    assert_equal '2010', result[0]
    assert_equal '04', result[1]
    assert_equal '01' , result[2]
  end
  
  
  def test_convert_digit_to_string
    result = GamedayUtil.convert_digit_to_string(8)
    assert_equal '08', result
    
    result = GamedayUtil.convert_digit_to_string(0)
    assert_equal '00', result
    
    result = GamedayUtil.convert_digit_to_string(12)
    assert_equal '12', result
  end
  
  
  def test_parse_gameday_id
    gid = 'gid_2008_04_07_atlmlb_colmlb_1'
    gd_info = GamedayUtil.parse_gameday_id(gid)
    assert_not_nil gd_info
    assert_equal '2008', gd_info["year"]
    assert_equal '04', gd_info["month"]
    assert_equal '07', gd_info["day"]
    assert_equal 'atl', gd_info['visiting_team_abbrev']
    assert_equal 'col', gd_info['home_team_abbrev']
    assert_equal '1', gd_info['game_number']
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
