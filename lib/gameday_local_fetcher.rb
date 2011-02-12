require 'gameday_path_builder'


module Gameday
  # This class is responsible for retrieving gameday data files from the local file system.
  # It contains methods that read or open a connection to the XML files that have been saved 
  # to the local filesystem.
  class GamedayLocalFetcher
    
  
    # Fetch the epg.xml file
    # Sample PATH:  components/game/mlb/year_2008/month_04/day_07/epg.xml
    def self.fetch_epg(year, month, day)
      path = GamedayPathBuilder.build_epg_path(year, month, day)
      GamedayUtil.read_file(path)
    end
  
  
    # Fetch the master scoreboard file
    # Sample PATH:  components/game/mlb/year_2008/month_04/day_07/master_scoreboard.xml
    def self.fetch_scoreboard(year, month, day)
      path = GamedayPathBuilder.build_scoreboard_path(year, month, day)
      GamedayUtil.read_file(path)
    end
  
  
    def self.fetch_day_highlights(year, month, day)
      path = GamedayPathBuilder.build_day_highlights_path(year, month, day)
      GamedayUtil.read_file(path)
    end
  
  
    # Fetch the bench.xml file
    # Sample PATH:  components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/bench.xml
    def self.fetch_bench(gid)
      path = GamedayPathBuilder.build_game_base_path(gid) + '/bench.xml'
      GamedayUtil.read_file(path)
    end
  
  
    # Fetch the benchO.xml file
    # Sample PATH:  components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/benchO.xml
    def self.fetch_bencho(gid)
      path = GamedayPathBuilder.build_game_base_path(gid) + '/benchO.xml'
      GamedayUtil.read_file(path)
    end
  
  
    # Fetches the boxscore.xml file and returns its contents
    # Sample PATH: components/game/mlb/year_2009/month_05/day_08/gid_2009_05_08_detmlb_clemlb_1/boxscore.xml
    def self.fetch_boxscore(gid)
      gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
      path = GamedayPathBuilder.build_boxscore_path(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
      GamedayUtil.read_file(path)
    end
  
  
    # Fetch the emailSource.xml file
    # Sample PATH:  components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/emailSource.xml
    def self.fetch_emailsource(gid)
      path = GamedayPathBuilder.build_game_base_path(gid) + '/emailSource.xml'
      GamedayUtil.read_file(path)
    end
  
  
    # Fetches the eventLog.xml file and returns its contents
    # Sample PATH: components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_flomlb_wasmlb_1/eventLog.xml
    def self.fetch_eventlog(gid)
      gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
      path = GamedayPathBuilder.build_eventlog_path(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
      GamedayUtil.read_file(path)
    end
  
  
    # Fetches the game.xml file and returns its contents
    def self.fetch_game_xml(gid)
      gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
      path = GamedayPathBuilder.build_game_path(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
      GamedayUtil.read_file(path)
    end
  
  
    def self.fetch_game_events(gid)
      gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
      path = GamedayPathBuilder.build_game_events_path(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
      GamedayUtil.read_file(path)
    end
  
  
    # Fetches the gamecenter.xml file and returns its contents
    def self.fetch_gamecenter_xml(gid)
      gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
      path = GamedayPathBuilder.build_gamecenter_path(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
      GamedayUtil.read_file(path)
    end
  
  
    # Fetch the gameday_Syn.xml file
    # Sample PATH:  components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/gameday_Syn.xml
    def self.fetch_gamedaysyn(gid)
      path = GamedayPathBuilder.build_game_base_path(gid) + '/gameday_Syn.xml'
      GamedayUtil.read_file(path)    
    end
  
  
    # Fetch the linescore.xml file
    # Sample PATH:  components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/linescore.xml
    def self.fetch_linescore(gid)
      gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
      path = GamedayPathBuilder.build_linescore_path(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
      GamedayUtil.read_file(path)
    end
  
  
    # Fetch the miniscoreboard.xml file
    # Sample PATH:  components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/miniscoreboard.xml
    def self.fetch_miniscoreboard(gid)
      path = GamedayPathBuilder.build_game_base_path(gid) + '/miniscoreboard.xml'
      GamedayUtil.read_file(path)   
    end
  
  
    # Fetches the players.xml file and returns its contents
    def self.fetch_players(gid)
      gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
      path = GamedayPathBuilder.build_players_path(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
      GamedayUtil.read_file(path)
    end
  
  
    # Fetch the plays.xml file
    # Sample PATH:  components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/plays.xml
    def self.fetch_plays(gid)
      path = GamedayPathBuilder.build_game_base_path(gid) + '/plays.xml'
      GamedayUtil.read_file(path)
    end
  
  
    # Fetches the batters/(pid).xml file
    def self.fetch_batter(gid, pid)
      gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
      path = GamedayPathBuilder.build_batter_path(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid, pid)
      GamedayUtil.read_file(path)
    end
  
  
    # Fetches the pitchers/(pid).xml file
    def self.fetch_pitcher(gid, pid)
      gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
      path = GamedayPathBuilder.build_pitcher_path(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid, pid)
      GamedayUtil.read_file(path)
    end
  
    #     inning/inning_X.xml 
    def self.fetch_inningx(gid, inning_num)
      gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
      path = GamedayPathBuilder.build_inningx_path(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid, inning_num)
      GamedayUtil.read_file(path)
    end


  #     inning/inning_Score.xml
    def self.fetch_inning_scores(gid) 
      gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
      path = GamedayPathBuilder.build_inning_scores_path(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
      GamedayUtil.read_file(path)
    end
  

  #     inning/inning_hit.xml
    def self.fetch_inning_hit(gid)
      gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
      path = GamedayPathBuilder.build_inning_hit_path(gameday_info['year'] , gameday_info['month'], gameday_info['day'] , gid)
      GamedayUtil.read_file(path)
    end
  
  
    # Fetches the HTML page that lists all games for the specified date
    def self.fetch_games_page(year, month, day)
      puts 'LOCAL = fetching games page - ' + year.to_s + ' ' + month.to_s + ' ' + day.to_s
      path = GamedayPathBuilder.build_day_path(year, month, day) + 'games.html'
      puts 'PATH = ' + path
      GamedayUtil.read_file(path)
    end
  
  
    # Fetches the HTML page that lists all games for the specified date
    def self.fetch_batters_page(gid)
      path = GamedayPathBuilder.build_game_base_path(gid) + '/batters.html'
      GamedayUtil.read_file(path)
    end
  
  
    # Fetches the HTML page that lists all games for the specified date
    def self.fetch_pitchers_page(gid)
      path = GamedayPathBuilder.build_game_base_path(gid) + '/pitchers.html'
      GamedayUtil.read_file(path)
    end
  
  
    def self.fetch_media_highlights(gid)
      path = GamedayPathBuilder.build_game_base_path(gid) + '/media/highlights.xml'
      GamedayUtil.read_file(path)
    end
  
  
    def self.fetch_media_mobile(gid)
      path = GamedayPathBuilder.build_game_base_path(gid) + '/media/mobile.xml'
      GamedayUtil.read_file(path)
    end
  
  
    def self.fetch_onbase_linescore(gid)
      path = GamedayPathBuilder.build_game_base_path(gid) + '/onbase/linescore.xml'
      GamedayUtil.read_file(path)
    end
  
  
    def self.fetch_onbase_plays(gid)
      path = GamedayPathBuilder.build_game_base_path(gid) + '/onbase/plays.xml'
      GamedayUtil.read_file(path)
    end
  
  
    def self.fetch_notifications_inning(gid, inning)
      path = GamedayPathBuilder.build_game_base_path(gid) + "/notifications/notifications_#{inning}.xml"
      GamedayUtil.read_file(path)
    end
  
  
    def self.fetch_notifications_full(gid)
      path = GamedayPathBuilder.build_game_base_path(gid) + "/notifications/notifications_full.xml"
      GamedayUtil.read_file(path)
    end

  
  end
end