require 'net/http'
require 'open-uri'
require 'hpricot'
require 'erb'
require 'game'
require 'box_score'


class Gameday

  GD2_MLB_BASE = "http://gd2.mlb.com/components/game"
    
    
  def initialize
    @proxy_addr = '10.0.6.251'
    @proxy_port = '3128'
    super
  end
  
  
  # Returns an array of Game objects for each game for the specified day
  def get_all_games_for_date(year, month, day)
    begin 
      games = []
      url = "#{GD2_MLB_BASE}/mlb/year_#{year}/month_#{month}/day_#{day}/"
      connection = get_connection(url)
      if connection
        @hp = Hpricot(connection) 
        a = @hp.at('ul')  
        (a/"a").each do |link|
          if link.inner_html.include?('gid')
            str = link.inner_html
            gid = str[5..str.length-2]
            game = Game.new(gid)
            games.push game
          end
        end
      end
      connection.close
      return games
    rescue
      puts "No games data found for #{year}, #{month}, #{day}."
    end
  end
  
  
  def dump_boxscore_for_game(game) 
    gid = game.gid
    if gid
      bs = BoxScore.new
      bs.load_from_id(gid)
      save_file("boxscore.html", bs.to_html('boxscore.html.erb'))
    else
      puts "No data for input specified"
    end
  end
  
  
  # Returns an array of game id's for the given date
  def get_all_gids_for_date(year, month, day)
    begin 
      gids = []
      url = "#{GD2_MLB_BASE}/mlb/year_#{year}/month_#{month}/day_#{day}/"
      connection = get_connection(url)
      if connection
        @hp = Hpricot(connection) 
        a = @hp.at('ul')  
        (a/"a").each do |link|
          if link.inner_html.include?('gid')
            str = link.inner_html
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
  
  
  # Returns the game id associated with the given date and team
  def find_gid_for_team(year, month, day, team_abbrev)
    begin 
      url = "#{GD2_MLB_BASE}/mlb/year_#{year}/month_#{month}/day_#{day}/"
      connection = get_connection(url)
      if connection
        @hp = Hpricot(connection) 
        a = @hp.at('ul')  
        (a/"a").each do |link|
          if link.inner_html.include?('gid')
            if link.inner_html.include?(team_abbrev)
              str = link.inner_html
              connection.close
              return str[5..str.length-2]
            end
          end
        end
      end
      connection.close
      puts "No games data found for #{year}, #{month}, #{day}, #{team_abbrev}."
      return nil
    rescue
      puts "No games data found for #{year}, #{month}, #{day}, #{team_abbrev}."
    end
  end
  
  
  def dump_boxscore(year, month, date, team)    
    gid = find_gid_for_team(year, month, date, team)
    if gid
      bs = BoxScore.new
      bs.load_from_id(gid)
      save_file("boxscore.html", bs.to_html('boxscore.html.erb'))
    else
      puts "No data for input specified"
    end
  end
  
  
  private
  
  def get_connection(url)
    if @proxy_addr
      connection = open(url, :proxy => "http://#{@proxy_addr}:#{@proxy_port}")
    else
      connection = open(url)
    end
    connection
  end
  
  
  def save_file(filename, data)
    File.open(filename, 'w') {|f| f.write(data) }
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



