require 'rubygems'
require 'net/http'
require 'nokogiri'
require_relative 'game'
require_relative 'team'
require_relative 'box_score'

module GamedayApi
  class Gameday

    # Change this to point to the server you are reading Gameday data from
    GD2_MLB_BASE = "http://gd2.mlb.com/components/game"
    
    
    def initialize
      super
    end
  
  
    # Returns an array of game id's for the given date
    def get_all_gids_for_date(year, month, day)
      begin 
        gids = []
        url = GamedayUtil.build_day_url(year, month, date)
        connection = GamedayUtil.get_connection(url)
        if connection
          doc = Nokogiri::HTML(connection) 
          a = doc.css('a')  
          (a/"a").each do |link|
            if link.text.include?('gid')
              str = link.text
              gids.push str[5..str.length-2]
            end
          end
        end
        connection.close
        return gids
      rescue
        puts "No games data found for #{year}, #{month}, #{day}."
      end
    end
  
  
    # Converts numbers to two character strings by prepending a '0' if number
    # is less than 10.
    def convert_to_two_digit_str(number)
      if number < 10
        return '0'+number.to_s
      else
        return number.to_s
      end
    end
  
  end
end


