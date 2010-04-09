
# This class is responsible for retrieving gameday data files from the local file system.
# It contains methods that read or open a connection to the XML files that have been saved to the local filesystem.
# 
require 'gameday_path_builder'


class LocalFetcher
  
  # Fetch the bench.xml file
  # Sample PATH:  components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/bench.xml
  def self.fetch_bench(gid)
    url = GamedayPathBuilder.build_game_base_path(gid) + '/bench.xml'
    GamedayUtil.net_http.get_response(URI.parse(url)).body
  end
  
  
  # Fetch the benchO.xml file
  # Sample PATH:  components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/benchO.xml
  def self.fetch_bencho(gid)
    url = GamedayPathBuilder.build_game_base_path(gid) + '/benchO.xml'
    GamedayUtil.net_http.get_response(URI.parse(url)).body
  end
  
  
  # Fetches the boxscore.xml file and returns its contents
  # Sample PATH: components/game/mlb/year_2009/month_05/day_08/gid_2009_05_08_detmlb_clemlb_1/boxscore.xml
  def self.fetch_boxscore(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayPathBuilder.build_boxscore_path(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    GamedayUtil.net_http.get_response(URI.parse(url)).body
  end
  
  
  # Fetch the emailSource.xml file
  # Sample PATH:  components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/emailSource.xml
  def self.fetch_emailsource(gid)
    url = GamedayPathBuilder.build_game_base_path(gid) + '/emailSource.xml'
    GamedayUtil.net_http.get_response(URI.parse(url)).body
  end
  
  
end