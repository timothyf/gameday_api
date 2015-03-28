require_relative 'gameday_remote_fetcher'
require_relative 'gameday_local_fetcher'

module GamedayApi

  # This class is responsible for retrieving the Gameday files.
  # It uses either a remote or a local fetcher to get the files from a
  # remote server or the local file system.
  # 
  # The files that can be fetched using this class:
  #
  ##### THESE FILES ARE ASSOCIATED WITH A SPECIFIC DATE
  #     epg.xml
  #     master_scoreboard.xml
  #     media/highlights.xml
  #
  ##### HTML PAGES THAT CAN BE RETRIEVED
  #     games page => this page lists all games for the selected date
  #     batters page => this page lists all batter files for the selected game
  #     pitchers page => this page lists all pitcher files for the selected game
  #
  ##### FILES THAT ARE ASSOCIATED WITH A SPECIFIC GAME IDENTIFIED BY A GID  ##############
  #     bench.xml
  #     benchO.xml
  #     boxscore.xml
  #     emailSource.xml
  #     eventLog.xml
  #     game.xml
  #     game_events.xml
  #     gamecenter.xml
  #     gameday_Syn.xml
  #     linescore.xml
  #     miniscoreboard.xml
  #     players.xml
  #     plays.xml
  #
  #     batters/(pid).xml
  #     pitchers/(pid).xml
  #
  #     inning/inning_X.xml 
  #     inning/inning_Scores.xml
  #     inning/inning_hit.xml
  #
  #     onbase/linescore.xml
  #     onbase/plays.xml
  #
  #     media/highlights.xml
  #     media/mobile.xml
  #
  #     notifications/notifications_X.xml where X is an inning number
  #     notifications/notifications_full.xml
  #
  class GamedayFetcher
  
    # LOCAL OR REMOTE CONFIG IS NOW SET IN THE gameday_config.yml file
    # DO NOT MODIFY THIS
    # Uncomment the fetcher that you want to use
    #   GamedayRemoteFetcher - gets data from remote url
    #   GamedayLocalFetcher - gets data from locally stored files
    #def self.fetcher
    #  GamedayRemoteFetcher
      #GamedayLocalFetcher
    #end
  
  
    def self.fetch_epg(year, month, day)
      GamedayUtil.fetcher.fetch_epg(year, month, day)
    end
  
  
    # Fetch the master scoreboard file
    # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/master_scoreboard.xml
    def self.fetch_scoreboard(year, month, day)
      GamedayUtil.fetcher.fetch_scoreboard(year, month, day)
    end
  
  
    def self.fetch_day_highlights(year, month, day)
      GamedayUtil.fetcher.fetch_day_highlights(year, month, day)
    end
  
  
    # Fetch the bench.xml file
    # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/bench.xml
    def self.fetch_bench(gid)
      GamedayUtil.fetcher.fetch_bench(gid)
    end
  
  
    # Fetch the benchO.xml file
    # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/benchO.xml
    def self.fetch_bencho(gid)
      GamedayUtil.fetcher.fetch_bencho(gid)
    end
  
  
    # Fetches the boxscore.xml file and returns its contents
    # Sample URL: http://gd2.mlb.com/components/game/mlb/year_2009/month_05/day_08/gid_2009_05_08_detmlb_clemlb_1/boxscore.xml
    def self.fetch_boxscore(gid)
      GamedayUtil.fetcher.fetch_boxscore(gid)
    end
  
  
    # Fetch the emailSource.xml file
    # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/emailSource.xml
    def self.fetch_emailsource(gid)
      GamedayUtil.fetcher.fetch_emailsource(gid) 
    end
  
  
    # Fetches the eventLog.xml file and returns its contents
    # Sample URL: http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_flomlb_wasmlb_1/eventLog.xml
    def self.fetch_eventlog(gid)
      GamedayUtil.fetcher.fetch_eventlog(gid)
    end
  
  
    # Fetches the game.xml file and returns its contents
    def self.fetch_game_xml(gid)
      GamedayUtil.fetcher.fetch_game_xml(gid)
    end
  
  
    def self.fetch_game_events(gid)
      GamedayUtil.fetcher.fetch_game_events(gid)
    end
  
  
    # Fetches the gamecenter.xml file and returns its contents
    def self.fetch_gamecenter_xml(gid)
      GamedayUtil.fetcher.fetch_gamecenter_xml(gid)
    end
  
  
    # Fetch the gameday_Syn.xml file
    # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/gameday_Syn.xml
    def self.fetch_gamedaysyn(gid)
      GamedayUtil.fetcher.fetch_gamedaysyn(gid)  
    end
  
  
    # Fetch the linescore.xml file
    # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/linescore.xml
    def self.fetch_linescore(gid)
      GamedayUtil.fetcher.fetch_linescore(gid)
    end
  
  
    # Fetch the miniscoreboard.xml file
    # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/miniscoreboard.xml
    def self.fetch_miniscoreboard(gid)
      GamedayUtil.fetcher.fetch_miniscoreboard(gid)   
    end
  
  
    # Fetches the players.xml file and returns its contents
    def self.fetch_players(gid)
      GamedayUtil.fetcher.fetch_players(gid)
    end
  
  
    # Fetch the plays.xml file
    # Sample URL:  http://gd2.mlb.com/components/game/mlb/year_2008/month_04/day_07/gid_2008_04_07_atlmlb_colmlb_1/plays.xml
    def self.fetch_plays(gid)
      GamedayUtil.fetcher.fetch_plays(gid)
    end
  
  
    # Fetches the batters/(pid).xml file
    def self.fetch_batter(gid, pid)
      GamedayUtil.fetcher.fetch_batter(gid, pid)
    end
  
  
    # Fetches the pitchers/(pid).xml file
    def self.fetch_pitcher(gid, pid)
      GamedayUtil.fetcher.fetch_pitcher(gid, pid)
    end
  
    #     inning/inning_X.xml 
    def self.fetch_inningx(gid, inning_num)
      GamedayUtil.fetcher.fetch_inningx(gid, inning_num)
    end


  #     inning/inning_Score.xml
    def self.fetch_inning_scores(gid) 
      GamedayUtil.fetcher.fetch_inning_scores(gid)
    end
  

  #     inning/inning_hit.xml
    def self.fetch_inning_hit(gid)
      GamedayUtil.fetcher.fetch_inning_hit(gid)
    end
  
  
    # Fetches the HTML page that lists all games for the specified date
    def self.fetch_games_page(year, month, day)
      GamedayUtil.fetcher.fetch_games_page(year, month, day)
    end
  
  
    # Fetches the HTML page that lists all games for the specified date
    def self.fetch_batters_page(gid)
      GamedayUtil.fetcher.fetch_batters_page(gid)
    end
  
  
    # Fetches the HTML page that lists all games for the specified date
    def self.fetch_pitchers_page(gid)
      GamedayUtil.fetcher.fetch_pitchers_page(gid)
    end
  
  
    def self.fetch_media_highlights(gid)
      GamedayUtil.fetcher.fetch_media_highlights(gid)
    end
  
  
    def self.fetch_media_mobile(gid)
      GamedayUtil.fetcher.fetch_media_mobile(gid)
    end
  
  
    def self.fetch_onbase_linescore(gid)
      GamedayUtil.fetcher.fetch_onbase_linescore(gid)
    end
  
  
    def self.fetch_onbase_plays(gid)
      GamedayUtil.fetcher.fetch_onbase_plays(gid)
    end
  
  
    def self.fetch_notifications_inning(gid, inning)
      GamedayUtil.fetcher.fetch_notifications_inning(gid, inning)
    end
  
  
    def self.fetch_notifications_full(gid)
      GamedayUtil.fetcher.fetch_notifications_full(gid)
    end
  end
  
end