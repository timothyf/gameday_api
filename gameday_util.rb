
class GamedayUtil
  
  # Example gameday_gid = gid_2009_06_21_milmlb_detmlb_1
  def self.parse_gameday_id(gameday_gid)
    gameday_info = {}
    gameday_info["year"] = gameday_gid[4..7]
    gameday_info["month"] = gameday_gid[9..10]
    gameday_info["day"] = gameday_gid[12..13]
    gameday_info["visiting_team_abbrev"] = gameday_gid[15..17]
    gameday_info["home_team_abbrev"] = gameday_gid[22..24]
    gameday_info["game_number"] = gameday_gid[29..29]
    return gameday_info
  end
  

  
end