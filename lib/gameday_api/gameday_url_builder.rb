require 'gameday_api/gameday'

module GamedayApi

  class GamedayUrlBuilder
  
    def self.build_game_base_url(gid)
      gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
      "#{Gameday::GD2_MLB_BASE}/mlb/year_" + gameday_info['year'] + "/month_" + gameday_info['month'] + "/day_" + gameday_info['day'] + "/gid_"+gid 
    end
  
  
    def self.build_eventlog_url(year, month, day, gid)
      set_date_vars(year, month, day)
      "#{Gameday::GD2_MLB_BASE}/mlb/year_" + @@year + "/month_" + @@month + "/day_" + @@day + "/gid_"+gid+"/eventLog.xml" 
    end
  
  
    def self.build_epg_url(year, month, day)
      set_date_vars(year, month, day)
      "#{Gameday::GD2_MLB_BASE}/mlb/year_" + @@year + "/month_" + @@month + "/day_" + @@day + "/epg.xml"
    end
  
  
    def self.build_scoreboard_url(year, month, day)
      set_date_vars(year, month, day)
      "#{Gameday::GD2_MLB_BASE}/mlb/year_" + @@year + "/month_" + @@month + "/day_" + @@day + "/master_scoreboard.xml"
    end
  
  
    def self.build_day_highlights_url(year, month, day)
      set_date_vars(year, month, day)
      "#{Gameday::GD2_MLB_BASE}/mlb/year_" + @@year + "/month_" + @@month + "/day_" + @@day + "/media/highlights.xml"
    end
  
  
    def self.build_boxscore_url(year, month, day, gid)
      set_date_vars(year, month, day)
      "#{Gameday::GD2_MLB_BASE}/mlb/year_" + @@year + "/month_" + @@month + "/day_" + @@day + "/gid_"+gid+"/boxscore.xml" 
    end
  
  
    def self.build_game_url(year, month, day, gid)
      set_date_vars(year, month, day)
      "#{Gameday::GD2_MLB_BASE}/mlb/year_" + @@year + "/month_" + @@month + "/day_" + @@day + "/gid_"+gid+"/game.xml" 
    end
  
  
    def self.build_game_events_url(year, month, day, gid)
      set_date_vars(year, month, day)
      "#{Gameday::GD2_MLB_BASE}/mlb/year_" + @@year + "/month_" + @@month + "/day_" + @@day + "/gid_"+gid+"/game_events.xml" 
    end
  
  
    def self.build_gamecenter_url(year, month, day, gid)
      set_date_vars(year, month, day)
      "#{Gameday::GD2_MLB_BASE}/mlb/year_" + @@year + "/month_" + @@month + "/day_" + @@day + "/gid_"+gid+"/gamecenter.xml" 
    end


    def self.build_linescore_url(year, month, day, gid)
      set_date_vars(year, month, day)
      "#{Gameday::GD2_MLB_BASE}/mlb/year_" + @@year + "/month_" + @@month + "/day_" + @@day + "/gid_"+gid+"/linescore.xml" 
    end
  

    def self.build_players_url(year, month, day, gid)
      set_date_vars(year, month, day)
      "#{Gameday::GD2_MLB_BASE}/mlb/year_" + @@year + "/month_" + @@month + "/day_" + @@day + "/gid_"+gid+"/players.xml" 
    end
  
  
    def self.build_batter_url(year, month, day, gid, pid)
      set_date_vars(year, month, day)
      "#{Gameday::GD2_MLB_BASE}/mlb/year_" + @@year + "/month_" + @@month + "/day_" + @@day + "/gid_"+gid+"/batters/" +  pid + '.xml'
    end
  
  
    def self.build_pitcher_url(year, month, day, gid, pid)
      set_date_vars(year, month, day)
      "#{Gameday::GD2_MLB_BASE}/mlb/year_" + @@year + "/month_" + @@month + "/day_" + @@day + "/gid_"+gid+"/pitchers/" +  pid + '.xml' 
    end
  
  
    def self.build_inningx_url(year, month, day, gid, inning_num)
      set_date_vars(year, month, day)
      "#{Gameday::GD2_MLB_BASE}/mlb/year_" + @@year + "/month_" + @@month + "/day_" + @@day + "/gid_"+gid+"/inning/inning_#{inning_num}.xml"
    end
  
  
    def self.build_inning_scores_url(year, month, day, gid)
      set_date_vars(year, month, day)
      "#{Gameday::GD2_MLB_BASE}/mlb/year_" + @@year + "/month_" + @@month + "/day_" + @@day + "/gid_"+gid+"/inning/inning_Scores.xml"
    end
  
  
    def self.build_inning_hit_url(year, month, day, gid)
      set_date_vars(year, month, day)
      "#{Gameday::GD2_MLB_BASE}/mlb/year_" + @@year + "/month_" + @@month + "/day_" + @@day + "/gid_"+gid+"/inning/inning_hit.xml"
    end
  

    def self.build_day_url(year, month, day)
      set_date_vars(year, month, day)
      "#{Gameday::GD2_MLB_BASE}/mlb/year_#{@@year}/month_#{@@month}/day_#{@@day}/"
    end
  
  
    def self.build_month_url(year, month)
      set_date_vars(year, month, nil)
      "#{Gameday::GD2_MLB_BASE}/mlb/year_#{@@year}/month_#{@@month}/"
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
