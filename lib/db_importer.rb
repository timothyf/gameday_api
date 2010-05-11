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