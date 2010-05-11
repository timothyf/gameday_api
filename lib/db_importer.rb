require 'pitchfx_db_manager'
require 'game'



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
  
  
  def import_for_month(year, month)
    start_date = Date.new(year.to_i, month.to_i) # first day of month
    end_date = (start_date >> 1)-1 # last day of month
    ((start_date)..(end_date)).each do |dt| 
      puts dt.day
      import_for_date(year, month, dt.day.to_s)
    end
  end
  
  
  def import_for_date(year, month, day)
    games = Game.find_by_date(year, month, day)
    games.each do |game|
      import_for_game(game.gid)
    end
  end
  

  def import_for_game(gid)
    game = Game.new(gid)
    visitor_id = @db.find_or_create_team(game.visiting_team)
    home_id = @db.find_or_create_team(game.home_team)
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
  
  
end