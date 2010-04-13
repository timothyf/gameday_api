require 'gameday_url_builder'

class GamedayRemoteFetcher
  
  
  def self.fetch(url)
    resp = GamedayUtil.net_http.get_response(URI.parse(url))
    case resp
    when Net::HTTPSuccess
      result = resp.body
    else
      result = nil
    end
    result    
  end
  
  
  def self.fetch_epg(year, month, day)
    url = GamedayUrlBuilder.build_epg_url(year, month, day)
    fetch(url)
  end
  
  
  # Fetch the master scoreboard file
  # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/master_scoreboard.xml
  def self.fetch_scoreboard(year, month, day)
    url = GamedayUrlBuilder.build_scoreboard_url(year, month, day)
    fetch(url)
  end
  
  
  def self.fetch_day_highlights(year, month, day)
    url = GamedayUrlBuilder.build_day_highlights_url(year, month, day)
    fetch(url)
  end
  
  
  # Fetch the bench.xml file
  # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/bench.xml
  def self.fetch_bench(gid)
    url = GamedayUrlBuilder.build_game_base_url(gid) + '/bench.xml'
    fetch(url)   
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetch the benchO.xml file
  # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/benchO.xml
  def self.fetch_bencho(gid)
    url = GamedayUrlBuilder.build_game_base_url(gid) + '/benchO.xml'
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetches the boxscore.xml file and returns its contents
  # Sample URL: http://gd2.mlb.com/components/game/mlb/year_2009/month_05/day_08/gid_2009_05_08_detmlb_clemlb_1/boxscore.xml
  def self.fetch_boxscore(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_boxscore_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetch the emailSource.xml file
  # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/emailSource.xml
  def self.fetch_emailsource(gid)
    url = GamedayUrlBuilder.build_game_base_url(gid) + '/emailSource.xml'
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url) 
  end
  
  
  # Fetches the eventLog.xml file and returns its contents
  # Sample URL: http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_flomlb_wasmlb_1/eventLog.xml
  def self.fetch_eventlog(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_eventlog_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    fetch(url)
  end
  
  
  # Fetches the game.xml file and returns its contents
  def self.fetch_game_xml(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_game_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  def self.fetch_game_events(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_game_events_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetches the gamecenter.xml file and returns its contents
  def self.fetch_gamecenter_xml(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_gamecenter_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetch the gameday_Syn.xml file
  # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/gameday_Syn.xml
  def self.fetch_gamedaysyn(gid)
    url = GamedayUrlBuilder.build_game_base_url(gid) + '/gameday_Syn.xml'
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)    
  end
  
  
  # Fetch the linescore.xml file
  # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/linescore.xml
  def self.fetch_linescore(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_linescore_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetch the miniscoreboard.xml file
  # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/miniscoreboard.xml
  def self.fetch_miniscoreboard(gid)
    url = GamedayUrlBuilder.build_game_base_url(gid) + '/miniscoreboard.xml'
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)   
  end
  
  
  # Fetches the players.xml file and returns its contents
  def self.fetch_players(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_players_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetch the plays.xml file
  # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/plays.xml
  def self.fetch_plays(gid)
    url = GamedayUrlBuilder.build_game_base_url(gid) + '/plays.xml'
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetches the batters/(pid).xml file
  def self.fetch_batter(gid, pid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_batter_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid, pid)
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetches the pitchers/(pid).xml file
  def self.fetch_pitcher(gid, pid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_pitcher_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid, pid)
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  #     inning/inning_X.xml 
  def self.fetch_inningx(gid, inning_num)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_inningx_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid, inning_num)
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end


#     inning/inning_Score.xml
  def self.fetch_inning_scores(gid) 
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_inning_scores_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  

#     inning/inning_hit.xml
  def self.fetch_inning_hit(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    url = GamedayUrlBuilder.build_inning_hit_url(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetches the HTML page that lists all games for the specified date
  def self.fetch_games_page(year, month, day)
    url = GamedayUrlBuilder.build_day_url(year, month, day)
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetches the HTML page that lists all games for the specified date
  def self.fetch_batters_page(gid)
    url = GamedayUrlBuilder.build_game_base_url(gid) + '/batters/'
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  # Fetches the HTML page that lists all games for the specified date
  def self.fetch_pitchers_page(gid)
    url = GamedayUrlBuilder.build_game_base_url(gid) + '/pitchers/'
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end

  
  def self.fetch_media_highlights(gid)
    url = GamedayUrlBuilder.build_game_base_url(gid) + '/media/highlights.xml'
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  def self.fetch_media_mobile(gid)
    url = GamedayUrlBuilder.build_game_base_url(gid) + '/media/mobile.xml'
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  def self.fetch_onbase_linescore(gid)
    url = GamedayUrlBuilder.build_game_base_url(gid) + '/onbase/linescore.xml'
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  def self.fetch_onbase_plays(gid)
    url = GamedayUrlBuilder.build_game_base_url(gid) + '/onbase/plays.xml'
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  def self.fetch_notifications_inning(gid, inning)
    url = GamedayUrlBuilder.build_game_base_url(gid) + "/notifications/notifications_#{inning}.xml"
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end
  
  
  def self.fetch_notifications_full(gid)
    url = GamedayUrlBuilder.build_game_base_url(gid) + "/notifications/notifications_full.xml"
    fetch(url)
    #fetcher = CacheFetcher.new()
    #return fetcher.fetch(url)
  end

  
end