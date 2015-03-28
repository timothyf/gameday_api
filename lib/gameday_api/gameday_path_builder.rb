require_relative 'gameday'

module GamedayApi

  class GamedayPathBuilder
  
    FILE_BASE_PATH = 'components/game/mlb'
  
    def self.year_month_day_path
      "year_" + @@year + "/month_" + @@month + "/day_" + @@day
    end
  
  
    def self.build_game_base_path(gid)
      gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
      "#{FILE_BASE_PATH}/year_" + gameday_info['year'] + "/month_" + gameday_info['month'] + "/day_" + gameday_info['day'] + "/gid_"+gid 
    end
  
  
    def self.build_eventlog_path(year, month, day, gid)
      set_date_vars(year, month, day)
      "#{FILE_BASE_PATH}/" + year_month_day_path + "/gid_"+gid+"/eventLog.xml" 
    end
  
  
    def self.build_epg_path(year, month, day)
      set_date_vars(year, month, day)
      "#{FILE_BASE_PATH}/" + year_month_day_path + "/epg.xml"
    end
  
  
    def self.build_scoreboard_path(year, month, day)
      set_date_vars(year, month, day)
      "#{FILE_BASE_PATH}/" + year_month_day_path + "/master_scoreboard.xml"
    end
  
  
    def self.build_day_highlights_path(year, month, day)
      set_date_vars(year, month, day)
      "#{FILE_BASE_PATH}/" + year_month_day_path + "/media/highlights.xml"
    end
  
  
    def self.build_boxscore_path(year, month, day, gid)
      set_date_vars(year, month, day)
      "#{FILE_BASE_PATH}/" + year_month_day_path + "/gid_"+gid+"/boxscore.xml" 
    end
  
  
    def self.build_game_path(year, month, day, gid)
      set_date_vars(year, month, day)
      "#{FILE_BASE_PATH}/" + year_month_day_path + "/gid_"+gid+"/game.xml" 
    end
  
  
    def self.build_game_events_path(year, month, day, gid)
      set_date_vars(year, month, day)
      "#{FILE_BASE_PATH}/" + year_month_day_path + "/gid_"+gid+"/game_events.xml" 
    end
  
  
    def self.build_gamecenter_path(year, month, day, gid)
      set_date_vars(year, month, day)
      "#{FILE_BASE_PATH}/" + year_month_day_path + "/gid_"+gid+"/gamecenter.xml" 
    end


    def self.build_linescore_path(year, month, day, gid)
      set_date_vars(year, month, day)
      "#{FILE_BASE_PATH}/" + year_month_day_path + "/gid_"+gid+"/linescore.xml" 
    end
  

    def self.build_players_path(year, month, day, gid)
      set_date_vars(year, month, day)
      "#{FILE_BASE_PATH}/" + year_month_day_path + "/gid_"+gid+"/players.xml" 
    end
  
  
    def self.build_batter_path(year, month, day, gid, pid)
      set_date_vars(year, month, day)
      "#{FILE_BASE_PATH}/" + year_month_day_path + "/gid_"+gid+"/batters/" +  pid + '.xml'
    end
  
  
    def self.build_pitcher_path(year, month, day, gid, pid)
      set_date_vars(year, month, day)
      "#{FILE_BASE_PATH}/" + year_month_day_path + "/gid_"+gid+"/pitchers/" +  pid + '.xml' 
    end
  
  
    def self.build_inningx_path(year, month, day, gid, inning_num)
      set_date_vars(year, month, day)
      "#{FILE_BASE_PATH}/" + year_month_day_path + "/gid_"+gid+"/inning/inning_#{inning_num}.xml"
    end
  
  
    def self.build_inning_scores_path(year, month, day, gid)
      set_date_vars(year, month, day)
      "#{FILE_BASE_PATH}/" + year_month_day_path + "/gid_"+gid+"/inning/inning_Scores.xml"
    end
  
  
    def self.build_inning_hit_path(year, month, day, gid)
      set_date_vars(year, month, day)
      "#{FILE_BASE_PATH}/" + year_month_day_path + "/gid_"+gid+"/inning/inning_hit.xml"
    end
  

    def self.build_day_path(year, month, day)
      set_date_vars(year, month, day)
      "#{FILE_BASE_PATH}/year_#{@@year}/month_#{@@month}/day_#{@@day}/"
    end
  
  
    def self.build_month_path(year, month)
      set_date_vars(year, month, nil)
      "#{FILE_BASE_PATH}/year_#{@@year}/month_#{@@month}/"
    end
  
  
    private
  
    def self.set_date_vars(year, month, day)
      @@year = GamedayUtil.convert_digit_to_string(year.to_i)
      @@month = GamedayUtil.convert_digit_to_string(month.to_i)
      if day
        @@day = GamedayUtil.convert_digit_to_string(day.to_i)
      end
    end
  
  
  end
end
