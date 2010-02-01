
class GamedayUrlBuilder
  
  
  def self.build_eventlog_url(year, month, day, gid)
    "#{Gameday::GD2_MLB_BASE}/mlb/year_" + year + "/month_" + month + "/day_" + day + "/gid_"+gid+"/eventLog.xml" 
  end
  
  
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
