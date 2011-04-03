require 'pitchfx_db_manager'
require 'game'
require 'date'



class DbImporter
  
# player

# team
# game
# atbat
# pitch
# pitch type
# game type
# umpire

  def initialize(host, user, password, db_name)
    @db = PitchfxDbManager.new(host, user, password, db_name)
  end
  
  
  def import_team_for_month(team_abbrev, year, month)
    start_date = Date.new(year.to_i, month.to_i) # first day of month
    end_date = (start_date >> 1)-1 # last day of month
    ((start_date)..(end_date)).each do |dt| 
      puts year.to_s + '/' + month.to_s + '/' + dt.day
      team = Team.new('det')
      games = team.games_for_date(year, month, dt.day.to_s)
      games.each do |game|
        import_for_game(game.gid)
      end
    end
  end
  
  
  def import_for_month(year, month)
    start_date = Date.new(year.to_i, month.to_i) # first day of month
    end_date = (start_date >> 1)-1 # last day of month
    ((start_date)..(end_date)).each do |dt| 
      puts dt.year.to_s + '/' + dt.month.to_s + '/' + dt.day.to_s
      import_for_date(dt.year.to_s, dt.month.to_s, dt.day.to_s)
    end
  end
  
  
  def import_for_range(year, start_month, start_day, end_month, end_day)
    start_date = Date.new(year.to_i, start_month.to_i, start_day.to_i)
    end_date = Date.new(year.to_i, end_month.to_i, end_day.to_i)
    ((start_date)..(end_date)).each do |dt| 
      puts dt.year.to_s + '/' + dt.month.to_s + '/' + dt.day.to_s
      import_for_date(dt.year.to_s, dt.month.to_s, dt.day.to_s)
    end
  end
  
  
  def import_for_date(year, month, day)
    games = Game.find_by_date(year, month, day)
    if games && games.length > 0
      games.each do |game|
        import_for_game(game.gid)
      end
    end
  end
  

  def import_for_game(gid)
    game = Game.new(gid)
    visitor_id = @db.find_or_create_team(game.visiting_team)
    home_id = @db.find_or_create_team(game.home_team)
    import_players_for_game(gid, visitor_id, home_id)
    game_id = @db.find_or_create_game(game, visitor_id, home_id)
    abs = game.get_atbats
    abs.each do |ab|
      atbat_id = @db.find_or_create_atbat(ab, game_id)
      pitches = ab.pitches
      pitches.each do |pitch|
        @db.find_or_create_pitch(pitch, atbat_id)
      end
    end
    import_pitcher_lines_for_game(gid)
    import_batting_stats_for_game(gid)
    import_linescores_for_game(gid)
    import_game_infos_for_game(gid)
    import_hitchart_for_game(gid)
    import_rosters_for_game(gid)
    update_pitching_season_stats_for_game(game.year, gid)
    update_batting_season_stats_for_game(game.year, gid)
  end
  
  
  def import_players_for_game(gid, visitor_id, home_id)
    players = Players.new
    players.load_from_id(gid)
    away = players.rosters[0]
    home = players.rosters[1]    
    away.players.each do |player|
      @db.find_or_create_player(player, visitor_id) 
    end
    home.players.each do |player|
      @db.find_or_create_player(player, home_id)
    end
  end
  
  
  def import_game_infos_for_month(year, month)
    start_date = Date.new(year.to_i, month.to_i) # first day of month
    end_date = (start_date >> 1)-1 # last day of month
    ((start_date)..(end_date)).each do |dt| 
      puts dt.year.to_s + '/' + dt.month.to_s + '/' + dt.day.to_s
      import_game_infos_for_date(dt.year.to_s, dt.month.to_s, dt.day.to_s)
    end
  end
  
  
  def import_game_infos_for_date(year, month, day)
    games = Game.find_by_date(year, month, day)
    if games && games.length > 0
      games.each do |game|
        import_game_infos_for_game(game.gid)
      end
    end
  end
  
  
  def import_game_infos_for_range(year, start_month, start_day, end_month, end_day)
    start_date = Date.new(year.to_i, start_month.to_i, start_day.to_i)
    end_date = Date.new(year.to_i, end_month.to_i, end_day.to_i)
    ((start_date)..(end_date)).each do |dt| 
      puts dt.year.to_s + '/' + dt.month.to_s + '/' + dt.day.to_s
      import_game_infos_for_date(dt.year.to_s, dt.month.to_s, dt.day.to_s)
    end
  end
  
  
  def import_game_infos_for_game(gid)
    @db.find_or_create_game_infos(Game.new(gid))
  end
  
  
  def import_linescores_for_month(year, month)
    start_date = Date.new(year.to_i, month.to_i) # first day of month
    end_date = (start_date >> 1)-1 # last day of month
    ((start_date)..(end_date)).each do |dt| 
      puts dt.year.to_s + '/' + dt.month.to_s + '/' + dt.day.to_s
      import_linescores_for_date(dt.year.to_s, dt.month.to_s, dt.day.to_s)
    end
  end
  
  
  def import_linescores_for_date(year, month, day)
    games = Game.find_by_date(year, month, day)
    if games && games.length > 0
      games.each do |game|
        import_linescores_for_game(game.gid)
      end
    end
  end
  
  
  def import_linescores_for_range(year, start_month, start_day, end_month, end_day)
    start_date = Date.new(year.to_i, start_month.to_i, start_day.to_i)
    end_date = Date.new(year.to_i, end_month.to_i, end_day.to_i)
    ((start_date)..(end_date)).each do |dt| 
      puts dt.year.to_s + '/' + dt.month.to_s + '/' + dt.day.to_s
      import_linescores_for_date(dt.year.to_s, dt.month.to_s, dt.day.to_s)
    end
  end
  
  
  def import_linescores_for_game(gid)
    game = Game.new(gid)
    linescore = game.get_boxscore.linescore
    @db.find_or_create_linescore(linescore, game)
  end
  
  
  def import_batting_stats_for_month(year, month)
    start_date = Date.new(year.to_i, month.to_i) # first day of month
    end_date = (start_date >> 1)-1 # last day of month
    ((start_date)..(end_date)).each do |dt| 
      puts dt.year.to_s + '/' + dt.month.to_s + '/' + dt.day.to_s
      import_batting_stats_for_date(dt.year.to_s, dt.month.to_s, dt.day.to_s)
    end
  end
  
  
  def import_batting_stats_for_date(year, month, day)
    games = Game.find_by_date(year, month, day)
    if games && games.length > 0
      games.each do |game|
        import_batting_stats_for_game(game.gid)
      end
    end
  end
  
  
  def import_batting_stats_for_range(year, start_month, start_day, end_month, end_day)
    start_date = Date.new(year.to_i, start_month.to_i, start_day.to_i)
    end_date = Date.new(year.to_i, end_month.to_i, end_day.to_i)
    ((start_date)..(end_date)).each do |dt| 
      puts dt.year.to_s + '/' + dt.month.to_s + '/' + dt.day.to_s
      import_batting_stats_for_date(dt.year.to_s, dt.month.to_s, dt.day.to_s)
    end
  end
  
  
  def import_batting_stats_for_game(gid)
    game = Game.new(gid)
    batters = game.get_boxscore.batters
    batters.each do |h_or_a_batters|
      h_or_a_batters.each do |batter|
        @db.find_or_create_batting_stat(batter, game)
      end
    end
  end
  
  
  def import_pitcher_lines_for_month(year, month)
    start_date = Date.new(year.to_i, month.to_i) # first day of month
    end_date = (start_date >> 1)-1 # last day of month
    ((start_date)..(end_date)).each do |dt| 
      puts dt.year.to_s + '/' + dt.month.to_s + '/' + dt.day.to_s
      import_pitcher_lines_for_date(dt.year.to_s, dt.month.to_s, dt.day.to_s)
    end
  end
  
  
  def import_pitcher_lines_for_date(year, month, day)
    games = Game.find_by_date(year, month, day)
    if games && games.length > 0
      games.each do |game|
        import_pitcher_lines_for_game(game.gid)
      end
    end
  end
  
  
  def import_pitcher_lines_for_range(year, start_month, start_day, end_month, end_day)
    start_date = Date.new(year.to_i, start_month.to_i, start_day.to_i)
    end_date = Date.new(year.to_i, end_month.to_i, end_day.to_i)
    ((start_date)..(end_date)).each do |dt| 
      puts dt.year.to_s + '/' + dt.month.to_s + '/' + dt.day.to_s
      import_pitcher_lines_for_date(dt.year.to_s, dt.month.to_s, dt.day.to_s)
    end
  end
  
  
  def import_pitcher_lines_for_game(gid)
    game = Game.new(gid)
    pitchers = game.get_boxscore.pitchers
    pitchers.each do |h_or_a_pitchers|
      h_or_a_pitchers.each do |pitcher|
        @db.find_or_create_pitcher_line(pitcher, game)
      end
    end
  end
  
  
  def set_status_for_range(year, start_month, start_day, end_month, end_day)
    start_date = Date.new(year.to_i, start_month.to_i, start_day.to_i)
    end_date = Date.new(year.to_i, end_month.to_i, end_day.to_i)
    ((start_date)..(end_date)).each do |dt| 
      puts dt.year.to_s + '/' + dt.month.to_s + '/' + dt.day.to_s
      set_status_for_date(dt.year.to_s, dt.month.to_s, dt.day.to_s)
    end
  end
  
  
  def set_status_for_date(year, month, day)
    games = Game.find_by_date(year, month, day)
    if games && games.length > 0
      games.each do |game|
        set_status_for_game(game.gid)
      end
    end
  end
  
  
  def set_status_for_game(gid)
    game = Game.new(gid)
    @db.update_status_for_game(game)
  end
  
  
  def import_hitchart_for_range(year, start_month, start_day, end_month, end_day)
    start_date = Date.new(year.to_i, start_month.to_i, start_day.to_i)
    end_date = Date.new(year.to_i, end_month.to_i, end_day.to_i)
    ((start_date)..(end_date)).each do |dt| 
      puts dt.year.to_s + '/' + dt.month.to_s + '/' + dt.day.to_s
      import_hitchart_for_date(dt.year.to_s, dt.month.to_s, dt.day.to_s)
    end
  end
  

  def import_hitchart_for_date(year, month, day)
    games = Game.find_by_date(year, month, day)
    if games && games.length > 0
      games.each do |game|
        import_hitchart_for_game(game.gid)
      end
    end
  end
  
  
  def import_hitchart_for_game(gid)
    game = Game.new(gid)
    hitchart = game.get_hitchart
    hitchart.hips.each do |hip|
      @db.find_or_create_hip(hip, game)
    end
  end
  
=begin
  def import_linescore_for_game(gid)
    game = Game.new(gid)
    linescore = game.get_boxscore.linescore
    linescore.innings.each do |inning|
      runs_home = inning[1]
      runs_away = inning[0]
      hits_home = 0
      hits_away = 0
      errors_home = 0
      errors_away = 0
      @db.find_or_create_linescore()
    end
  end
=end  
  
  def import_rosters_for_range(year, start_month, start_day, end_month, end_day)
    start_date = Date.new(year.to_i, start_month.to_i, start_day.to_i)
    end_date = Date.new(year.to_i, end_month.to_i, end_day.to_i)
    ((start_date)..(end_date)).each do |dt| 
      puts dt.year.to_s + '/' + dt.month.to_s + '/' + dt.day.to_s
      import_rosters_for_date(dt.year.to_s, dt.month.to_s, dt.day.to_s)
    end
  end
  
  
  def import_rosters_for_date(year, month, day)
    games = Game.find_by_date(year, month, day)
    if games && games.length > 0
      games.each do |game|
        import_rosters_for_game(game.gid)
      end
    end
  end
  
  
  def import_rosters_for_game(gid)
    game = Game.new(gid)
    away_id = @db.find_or_create_team(game.visiting_team)
    home_id = @db.find_or_create_team(game.home_team)
    players = Players.new
    players.load_from_id(gid)
    away = players.rosters[0]
    home = players.rosters[1]     
    roster_ids = @db.find_or_create_rosters(game, away_id, home_id) 
    away.players.each do |player|
      @db.find_or_create_roster_player(player, roster_ids[0]) 
    end
    home.players.each do |player|
      @db.find_or_create_roster_player(player, roster_ids[1])
    end
  end
  
  
  def update_rosters_for_range(year, start_month, start_day, end_month, end_day)
    start_date = Date.new(year.to_i, start_month.to_i, start_day.to_i)
    end_date = Date.new(year.to_i, end_month.to_i, end_day.to_i)
    ((start_date)..(end_date)).each do |dt| 
      puts dt.year.to_s + '/' + dt.month.to_s + '/' + dt.day.to_s
      update_rosters_for_date(dt.year.to_s, dt.month.to_s, dt.day.to_s)
    end    
  end
  
  
  def update_rosters_for_date(year, month, day)
    games = Game.find_by_date(year, month, day)
    if games && games.length > 0
      games.each do |game|
        update_rosters_for_game(game)
      end
    end
  end
  
  
  def update_rosters_for_game(game) 
    away_id = @db.find_or_create_team(game.visiting_team)
    home_id = @db.find_or_create_team(game.home_team)
    @db.update_rosters(game, away_id, home_id)
  end
  
  
  def import_highlights_for_month(year, month)
    start_date = Date.new(year.to_i, month.to_i) # first day of month
    end_date = (start_date >> 1)-1 # last day of month
    ((start_date)..(end_date)).each do |dt| 
      puts dt.year.to_s + '/' + dt.month.to_s + '/' + dt.day.to_s
      import_highlights_for_date(dt.year.to_s, dt.month.to_s, dt.day.to_s)
    end
  end
  
  
  def import_highlights_for_range(year, start_month, start_day, end_month, end_day)
    start_date = Date.new(year.to_i, start_month.to_i, start_day.to_i)
    end_date = Date.new(year.to_i, end_month.to_i, end_day.to_i)
    ((start_date)..(end_date)).each do |dt| 
      puts dt.year.to_s + '/' + dt.month.to_s + '/' + dt.day.to_s
      import_highlights_for_date(dt.year.to_s, dt.month.to_s, dt.day.to_s)
    end
  end
  
  
  def import_highlights_for_date(year, month, day)
    games = Game.find_by_date(year, month, day)
    if games && games.length > 0
      games.each do |game|
        import_highlights_for_game(game.gid)
      end
    end
  end
  
  
  def import_highlights_for_game(gid)
    game = Game.new(gid)
    media = game.get_media
    media.highlights.each do |highlight| 
      @db.find_or_create_highlight(highlight, game)
    end
  end
  
  
  def update_pitching_season_stats_for_month(year, month)
    start_date = Date.new(year.to_i, month.to_i) # first day of month
    end_date = (start_date >> 1)-1 # last day of month
    ((start_date)..(end_date)).each do |dt| 
      puts dt.year.to_s + '/' + dt.month.to_s + '/' + dt.day.to_s
      update_pitching_season_stats_for_date(dt.year.to_s, dt.month.to_s, dt.day.to_s)
    end
  end
  
  
  def update_pitching_season_stats_for_range(year, start_month, start_day, end_month, end_day)
    start_date = Date.new(year.to_i, start_month.to_i, start_day.to_i)
    end_date = Date.new(year.to_i, end_month.to_i, end_day.to_i)
    ((start_date)..(end_date)).each do |dt| 
      puts dt.year.to_s + '/' + dt.month.to_s + '/' + dt.day.to_s
      update_pitching_season_stats_for_date(dt.year.to_s, dt.month.to_s, dt.day.to_s)
    end
  end
  
  
  def update_pitching_season_stats_for_date(year, month, day)
    games = Game.find_by_date(year, month, day)
    if games && games.length > 0
      games.each do |game|
        update_pitching_season_stats_for_game(year, game.gid)
      end
    end
  end
  
  
  def update_pitching_season_stats_for_game(year, gid)
    game = Game.new(gid)
    if game.official?
      pitchers = game.get_boxscore.pitchers
      pitchers.each do |h_or_a_pitchers|
        h_or_a_pitchers.each do |pitcher|
          @db.create_or_update_pitching_stat(year, pitcher, game)
        end
      end
    end
  end
  
  
  def update_batting_season_stats_for_month(year, month)
    start_date = Date.new(year.to_i, month.to_i) # first day of month
    end_date = (start_date >> 1)-1 # last day of month
    ((start_date)..(end_date)).each do |dt| 
      puts dt.year.to_s + '/' + dt.month.to_s + '/' + dt.day.to_s
      update_batting_season_stats_for_date(dt.year.to_s, dt.month.to_s, dt.day.to_s)
    end
  end
  
  
  def update_batting_season_stats_for_range(year, start_month, start_day, end_month, end_day)
    start_date = Date.new(year.to_i, start_month.to_i, start_day.to_i)
    end_date = Date.new(year.to_i, end_month.to_i, end_day.to_i)
    ((start_date)..(end_date)).each do |dt| 
      puts dt.year.to_s + '/' + dt.month.to_s + '/' + dt.day.to_s
      update_batting_season_stats_for_date(dt.year.to_s, dt.month.to_s, dt.day.to_s)
    end
  end
  
  
  def update_batting_season_stats_for_date(year, month, day)
    games = Game.find_by_date(year, month, day)
    if games && games.length > 0
      games.each do |game|
        update_batting_season_stats_for_game(year, game.gid)
      end
    end
  end
  
  
  def update_batting_season_stats_for_game(year, gid)
    game = Game.new(gid)
    if game.official?
      batters = game.get_boxscore.batters
      batters.each do |h_or_a_batters|
        h_or_a_batters.each do |batter|
          @db.create_or_update_batting_stat(year, batter, game)
        end
      end
    end
  end
  
  
  def add_player_data(lahman_dbname)
    @db.add_player_data(lahman_dbname)
  end
  
  
  def update_pitches_with_batter_pitcher
    @db.update_pitches_with_batter_pitcher
  end
  
  
  def update_umpire_ids_for_games
    @db.update_umpire_ids_for_games
  end
  
  
  def import_pitch_relations
    @db.import_pitch_relations
  end
  
  
end