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
  
  
end