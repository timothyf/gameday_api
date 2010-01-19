#require 'cache_fetcher'


# This class is responsible for retrieving data from the Gameday server
# It contains methods that read or open a connection to the XML files hosted on gd2.mlb.com
# 
# The files that can be fetched using this class:
#
#     master_scoreboard.xml
#
#     boxscore.xml
#     game.xml
#     gamecenter.xml
#     players.xml
#     linescore.xml
#
#     batters/(pid).xml
#     pitchers/(pid).xml
#
#     inning/inning_X.xml 
#     inning/inning_Scores.xml
#     inning/inning_hit.xml
#
#     pbp/batters/(pid).xml
#     pbp/pitchers/(pid).xml
#
#     html page for game date
#
class GamedayFetcher
  
  # Fetch the master scoreboard file
  # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/master_scoreboard.xml
  def self.fetch_scoreboard(year, month, day)
    url = GamedayFetcher.build_scoreboard_url(year, month, day)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
  end
  
  
  # Fetches the boxscore.xml file and returns its contents
  def self.fetch_boxscore(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayFetcher.build_boxscore_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetches the game.xml file and returns its contents
  def self.fetch_game_xml(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayFetcher.build_game_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetches the gamecenter.xml file and returns its contents
  def self.fetch_gamecenter_xml(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayFetcher.build_gamecenter_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetches the players.xml file and returns its contents
  def self.fetch_players(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayFetcher.build_players_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  def self.fetch_linescore(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayFetcher.build_linescore_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetches the batters/(pid).xml file
  def self.fetch_batter(gid, pid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayFetcher.build_batter_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid, pid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetches the pitchers/(pid).xml file
  def self.fetch_pitcher(gid, pid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayFetcher.build_pitcher_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid, pid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  #     inning/inning_X.xml 
  def self.fetch_inningx(gid, inning_num)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayFetcher.build_inningx_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid, inning_num)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end


#     inning/inning_Score.xml
  def self.fetch_inning_scores(gid) 
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayFetcher.build_inning_scores_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  

#     inning/inning_hit.xml
  def self.fetch_inning_hit(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayFetcher.build_inning_hit_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  def self.fetch_pbp_batter(gid, pid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayFetcher.build_pbp_batter_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid, pid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  def self.fetch_pbp_pitcher(gid, pid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayFetcher.build_pbp_pitcher_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid, pid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetches the HTML page that lists all games for the specified date
  def self.fetch_games_page(year, month, day)
    url = GamedayFetcher.build_day_url(year, month, day)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Returns an open connection to a page for the specified date
  def self.fetch_gameday_connection(year, month, day)
      url = GamedayFetcher.build_day_url(year, month, day)
      GamedayUtil.get_connection(url)
  end
  
  
  ##########################################################################################
  
  def self.build_scoreboard_url(year, month, day)
    "#{Gameday::GD2_MLB_BASE}/mlb/year_" + year + "/month_" + month + "/day_" + day + "/master_scoreboard.xml"
  end
  
  
  def self.build_boxscore_url(year, month, day, gid)
    "#{Gameday::GD2_MLB_BASE}/mlb/year_" + year + "/month_" + month + "/day_" + day + "/gid_"+gid+"/boxscore.xml" 
  end
  
  
  def self.build_game_url(year, month, day, gid)
    "#{Gameday::GD2_MLB_BASE}/mlb/year_" + year + "/month_" + month + "/day_" + day + "/gid_"+gid+"/game.xml" 
  end
  
  
  def self.build_gamecenter_url(year, month, day, gid)
    "#{Gameday::GD2_MLB_BASE}/mlb/year_" + year + "/month_" + month + "/day_" + day + "/gid_"+gid+"/gamecenter.xml" 
  end


  def self.build_linescore_url(year, month, day, gid)
    "#{Gameday::GD2_MLB_BASE}/mlb/year_" + year + "/month_" + month + "/day_" + day + "/gid_"+gid+"/linescore.xml" 
  end
  

  def self.build_players_url(year, month, day, gid)
    "#{Gameday::GD2_MLB_BASE}/mlb/year_" + year + "/month_" + month + "/day_" + day + "/gid_"+gid+"/players.xml" 
  end
  
  
  def self.build_batter_url(year, month, day, gid, pid)
    "#{Gameday::GD2_MLB_BASE}/mlb/year_" + year + "/month_" + month + "/day_" + day + "/gid_"+gid+"/batters/" +  pid + '.xml'
  end
  
  
  def self.build_pitcher_url(year, month, day, gid, pid)
    "#{Gameday::GD2_MLB_BASE}/mlb/year_" + year + "/month_" + month + "/day_" + day + "/gid_"+gid+"/pitchers/" +  pid + '.xml' 
  end
  
  
  def self.build_pbp_batter_url(year, month, day, gid, pid)
    "#{Gameday::GD2_MLB_BASE}/mlb/year_" + year + "/month_" + month + "/day_" + day + "/gid_"+gid+"/pbp/batters/" +  pid + '.xml'
  end
  
  
  def self.build_pbp_pitcher_url(year, month, day, gid, pid)
    "#{Gameday::GD2_MLB_BASE}/mlb/year_" + year + "/month_" + month + "/day_" + day + "/gid_"+gid+"/pbp/pitchers/" +  pid + '.xml' 
  end
  
  
  def self.build_inningx_url(year, month, day, gid, inning_num)
    "#{Gameday::GD2_MLB_BASE}/mlb/year_" + year + "/month_" + month + "/day_" + day + "/gid_"+gid+"/inning/inning_#{inning_num}.xml"
  end
  
  
  def self.build_inning_scores_url(year, month, day, gid)
    "#{Gameday::GD2_MLB_BASE}/mlb/year_" + year + "/month_" + month + "/day_" + day + "/gid_"+gid+"/inning/inning_Scores.xml"
  end
  
  
  def self.build_inning_hit_url(year, month, day, gid)
    "#{Gameday::GD2_MLB_BASE}/mlb/year_" + year + "/month_" + month + "/day_" + day + "/gid_"+gid+"/inning/inning_hit.xml"
  end
  

  def self.build_day_url(year, month, day)
    "#{Gameday::GD2_MLB_BASE}/mlb/year_#{year}/month_#{month}/day_#{day}/"
  end
  
end