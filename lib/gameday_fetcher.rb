#require 'cache_fetcher'
require 'gameday'
require 'gameday_url_builder'


# This class is responsible for retrieving data from the Gameday server
# It contains methods that read or open a connection to the XML files hosted on gd2.mlb.com
# 
# The files that can be fetched using this class:
#
#     master_scoreboard.xml
#     html page for game date
#
##### FILES THAT ARE ASSOCIATED WITH A SPECIFIC GAME IDENTIFIED BY A GID  ##############
#     bench.xml
#     benchO.xml
#     boxscore.xml
#     emailSource.xml
#     eventLog.xml
#     game.xml
#     gamecenter.xml
#     gameday_Syn.xml
#     linescore.xml
#     miniscoreboard.xml
#     players.xml
#     plays.xml
#     preview_atl.xml
#     preview_col.xml
#     seriesglance_mlb.xml
#     wrapupxml.xml
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
#
class GamedayFetcher
  
  
  # Fetch the bench.xml file
  # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/bench.xml
  def self.fetch_bench(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_bench_url(gid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetch the benchO.xml file
  # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/benchO.xml
  def self.fetch_bencho(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
  end
  
  
  # Fetches the boxscore.xml file and returns its contents
  # Sample URL: http://gd2.mlb.com/components/game/mlb/year_2009/month_05/day_08/gid_2009_05_08_detmlb_clemlb_1/boxscore.xml
  def self.fetch_boxscore(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_boxscore_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetch the emailSource.xml file
  # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/emailSource.xml
  def self.fetch_emailsource(gid)
    
  end
  
  
  # Fetches the eventLog.xml file and returns its contents
  # Sample URL: http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_flomlb_wasmlb_1/eventLog.xml
  def self.fetch_eventlog(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_eventlog_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
  end
  
  
  # Fetches the game.xml file and returns its contents
  def self.fetch_game_xml(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_game_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetches the gamecenter.xml file and returns its contents
  def self.fetch_gamecenter_xml(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_gamecenter_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetch the gameday_Syn.xml file
  # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/gameday_Syn.xml
  def self.fetch_gamedaysyn(gid)
    
  end
  
  
  # Fetch the linescore.xml file
  # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/linescore.xml
  def self.fetch_linescore(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_linescore_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetch the miniscoreboard.xml file
  # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/miniscoreboard.xml
  def self.fetch_miniscoreboard(gid)
    
  end
  
  
  # Fetches the players.xml file and returns its contents
  def self.fetch_players(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_players_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetch the plays.xml file
  # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/plays.xml
  def self.fetch_plays(gid)
    
  end
  
  
  # Fetch the preview_atl.xml file
  # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/preview_atl.xml
  def self.fetch_preview_home(gid)
    
  end
  
  
  # Fetch the preview_col.xml file
  # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/preview_col.xml
  def self.fetch_preview_visitor(gid)
    
  end
  
  
  # Fetch the seriesglance_mlb.xml file
  # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/seriesglance_mlb.xml
  def self.fetch_seriesglance(gid)
    
  end
  
  
  # Fetch the wrapupxml.xml file
  # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/wrapupxml.xml
  def self.fetch_wrapup(gid)
    
  end
  
  
  # Fetch the master scoreboard file
  # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/master_scoreboard.xml
  def self.fetch_scoreboard(year, month, day)
    url = GamedayUrlBuilder.build_scoreboard_url(year, month, day)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
  end
  
  
  # Fetches the batters/(pid).xml file
  def self.fetch_batter(gid, pid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_batter_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid, pid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetches the pitchers/(pid).xml file
  def self.fetch_pitcher(gid, pid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_pitcher_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid, pid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  #     inning/inning_X.xml 
  def self.fetch_inningx(gid, inning_num)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_inningx_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid, inning_num)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end


#     inning/inning_Score.xml
  def self.fetch_inning_scores(gid) 
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_inning_scores_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  

#     inning/inning_hit.xml
  def self.fetch_inning_hit(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_inning_hit_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  def self.fetch_pbp_batter(gid, pid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_pbp_batter_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid, pid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  def self.fetch_pbp_pitcher(gid, pid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_pbp_pitcher_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid, pid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetches the HTML page that lists all games for the specified date
  def self.fetch_games_page(year, month, day)
    url = GamedayUrlBuilder.build_day_url(year, month, day)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Returns an open connection to a page for the specified date
  def self.fetch_gameday_connection(year, month, day)
      url = GamedayUrlBuilder.build_day_url(year, month, day)
      GamedayUtil.get_connection(url)
  end
  
  
  ##########################################################################################
  

  
end