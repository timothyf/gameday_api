require 'open-uri'
require 'yaml'


# This class provides a variety of utility methods that are used in other classes
class GamedayUtil
  
  # Parses a string with the date format of YYYYMMDD into an array
  # with the following elements:
  #    [0] = year
  #    [1] = month
  #    [2] = day
  def self.parse_date_string(date)
    results = []
    results << date[0..3]
    results << date[4..5]
    results << date[6..7] 
  end
  
  
  # Converts a digit into a 2 character string, prepended with '0' if necessary
  def self.convert_digit_to_string(digit)
    if digit<10
      return '0' + digit.to_s
    else
      return digit.to_s
    end
  end
  
  # Example gameday_gid = gid_2009_06_21_milmlb_detmlb_1
  def self.parse_gameday_id(gameday_gid)
    gameday_info = {}
    gameday_info["year"] = gameday_gid[4..7]
    gameday_info["month"] = gameday_gid[9..10]
    gameday_info["day"] = gameday_gid[12..13]
    gameday_info["visiting_team_abbrev"] = gameday_gid[15..17]
    gameday_info["home_team_abbrev"] = gameday_gid[22..24]
    gameday_info["game_number"] = gameday_gid[29..29]
    return gameday_info
  end


	# Read configuration from gameday_config.yml file to create
	# instance configuration variables.
	def self.read_config
    settings = YAML::load_file(File.expand_path(File.dirname(__FILE__) + "/gameday_config.yml"))
    #settings = YAML::load_file(File.expand_path('gameday_config.yml'))
    set_proxy_info(settings)
	end
  
  
  def self.get_connection(url)
    self.read_config
    begin
      if !@@proxy_addr.empty?
        connection = open(url, :proxy => "http://#{@@proxy_addr}:#{@@proxy_port}")
      else
        connection = open(url)
      end
      connection
    rescue
      puts 'Could not open connection'
    end
  end
  
  
  def self.net_http
    self.read_config
    if !@@proxy_addr.empty?
      return Net::HTTP::Proxy(@@proxy_addr, @@proxy_port)
    else
      return Net::HTTP
    end
  end
  
  
  def self.read_file(filename)
    
  end
  
  
  def self.save_file(filename, data)
    File.open(filename, 'w') {|f| f.write(data) }
  end
  
  
  def self.is_date_valid(month, date)
    if (month == 4 && date == 31) ||  
       (month == 6 && date == 31) ||
       (month == 9 && date == 31)
       return false
    end
    if month==4 and date<5 # start from 4/5 onward
      return false
    end
    return true
  end
  
  
  private
  
  def self.set_proxy_info(settings)
    @@proxy_addr, @@proxy_port = '', ''
    if settings['proxy']
      @@proxy_addr = settings['proxy']['host']
      @@proxy_port = settings['proxy']['port']
    end
  end
  
end