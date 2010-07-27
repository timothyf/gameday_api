require 'rubygems'
require 'mysql'


# This class is used to insert data into the pitchfx database
class PitchfxDbManager
  
  
    def initialize(host, user, password, db_name)
      @db = Mysql.real_connect(host, user, password, db_name)
    end
    
    
    def find_or_create_player(player, team_id)
      res = @db.query("select id from players where gameday_id = #{player.pid}")
      id=0
      if res.num_rows > 0
        res.each do |row|
          id = row[0]
        end
      else
        id = insert_player(player, team_id)
      end
      id
    end
    
    
    def find_or_create_team(team)
      res = @db.query("select id from teams where abbreviation = '#{team.abrev}'")
      id=0
      if res.num_rows > 0
        res.each do |row|
          id = row[0]
        end
      else
        id = insert_team(team)
      end
      id
    end
    
    
    def find_or_create_game(game, visitor_id, home_id)
      res = @db.query("select id from games where gid = '#{game.gid}'")
      id=0
      if res.num_rows > 0
        res.each do |row|
          id = row[0]
        end
      else
        id = insert_game(game, visitor_id, home_id)
      end
      id
    end
    
    
    def find_or_create_atbat(atbat, game_id)
      res = @db.query("select id from atbats where game_id = #{game_id} and num = #{atbat.num}")
      id=0
      if res.num_rows > 0
        res.each do |row|
          id = row[0]
        end
      else
        id = insert_atbat(atbat, game_id)
      end
      id
    end
    
    
    def find_or_create_pitch(pitch, atbat_id)
      res = @db.query("select id from pitches where pitch_id = '#{pitch.pitch_id}' and atbat_id = '#{atbat_id}'")
      id=0
      if res.num_rows > 0
        res.each do |row|
          id = row[0]
        end 
      else
        id = insert_pitch(pitch, atbat_id)
      end
      id
    end
    
    
    def find_or_create_umpire(umpire)
      res = @db.query("select id from umpires where id = #{umpire.id}")
      id=0
      if res.num_rows > 0
        res.each do |row|
          id = row[0]
        end
      else
        id = insert_umpire(umpire)
      end
      id
    end
    
    
    def find_or_create_pitch_type(type)
      res = @db.query("select id from pitch_types where id = #{type.id}")
      id=0
      if res.num_rows > 0
        res.each do |row|
          id = row[0]
        end
      else
        id = insert_pitch_type(type)
      end
      id
    end
    
    
    def find_or_create_game_type(type)
      res = @db.query("select id from game_types where id = #{type.id}")
      id=0
      if res.num_rows > 0
        res.each do |row|
          id = row[0]
        end 
      else
        id = insert_game_type(type)
      end
      id
    end
    
    
    def find_or_create_pitcher_line(pitcher, game)
      game_id = find_or_create_game(game, nil, nil)
      res = @db.query("select id from players where gameday_id = #{pitcher.pid}")
      pitcher_id=0
      res.each do |row|
        pitcher_id = row[0]
      end
      res = @db.query("select id from pitcher_lines where game_id = #{game_id} and pitcher_id = #{pitcher_id}")
      id=0
      if res.num_rows > 0
        res.each do |row|
          id = row[0]
        end 
      else
        id = insert_pitcher_line(pitcher, game_id, pitcher_id)
      end
      id
    end
    
    
    def insert_pitcher_line(pitcher, game_id, pitcher_id)
      #puts "INSERT INTO pitcher_lines (game_id, pitcher_id, name, pos, outs, bf, er, r, h, so, hr, bb, w, l, era, note) 
      #              VALUES ('#{game_id}', '#{pitcher_id}','#{pitcher.pitcher_name}','P', '#{pitcher.out}',
      #                     '#{pitcher.bf}','#{pitcher.er}','#{pitcher.r}','#{pitcher.h}','#{pitcher.so}','#{pitcher.hr}',
      #                     '#{pitcher.bb}','#{pitcher.w}','#{pitcher.l}','#{pitcher.era}','#{pitcher.note}')"
     name = @db.escape_string("#{pitcher.pitcher_name}")                    
     @db.query("INSERT INTO pitcher_lines (game_id, pitcher_id, name, pos, outs, bf, er, r, h, so, hr, bb, w, l, era, note) 
                  VALUES ('#{game_id}', '#{pitcher_id}','#{name}','P', '#{pitcher.out}','#{pitcher.bf}',
                          '#{pitcher.er}','#{pitcher.r}','#{pitcher.h}','#{pitcher.so}','#{pitcher.hr}','#{pitcher.bb}',
                          '#{pitcher.w}','#{pitcher.l}','#{pitcher.era}','#{pitcher.note}')")
     res = @db.query("select last_insert_id()")
     id = 0
     res.each do |row|
       id = row[0]
     end
     id
    end
      
    
    def insert_player(player, team_id)
      first = @db.escape_string("#{player.first}")
      last = @db.escape_string("#{player.last}")
      boxname = @db.escape_string("#{player.boxname}")
      @db.query("INSERT INTO players (team_id, gameday_id, first, last, number, boxname, position, throws) 
                   VALUES ('#{team_id}', '#{player.pid}','#{first}','#{last}',
                           '#{player.num}','#{boxname}','#{player.position}',
                           '#{player.rl}')")
      res = @db.query("select last_insert_id()")
      id = 0
      res.each do |row|
        id = row[0]
      end
      id
    end
      
    
    def insert_team(team)
      @db.query("INSERT INTO teams (abbreviation, city, name, stadium, created_at) 
                            VALUES ('#{team.abrev}', '#{team.city}','#{team.name}','', '#{Time.now}')")
      res = @db.query("select id from teams where name='#{team.name}'")
      id = 0
      res.each do |row|
        id = row[0]
      end
      id
    end
    
    
    def insert_atbat(atbat, game_id)
      desc = @db.escape_string("#{atbat.des}")
      @db.query("INSERT INTO atbats (game_id, inning, num, ball, strike, outs, batter_id,
             pitcher_id, stand, des, event, created_at) 
            VALUES ('#{game_id}','#{atbat.inning}','#{atbat.num}','#{atbat.b}','#{atbat.s}',
                    '#{atbat.o}','#{atbat.batter_id}','#{atbat.pitcher_id}','#{atbat.stand}',
                    '#{desc}','#{atbat.event}', '#{Time.now}')")
      res = @db.query("select last_insert_id()")
      id = 0
      res.each do |row|
        id = row[0]
      end
      id
    end
    
    
    def insert_pitch(pitch, atbat_id)
      @db.query("INSERT INTO pitches (atbat_id, pitch_id, description, outcome, x, y, start_speed, end_speed,
                      sz_top, sz_bot, pfx_x, pfx_z, px, pz, x0, y0, z0, vx0, vy0, vz0, ax, ay, az,
                      break_y, break_angle, break_length, on_1b, on_2b, on_3b,
                      sv_id, pitch_type, type_confidence, spin_dir, spin_rate, created_at) 
                              VALUES ('#{atbat_id}','#{pitch.pitch_id}', '#{pitch.des}','#{pitch.type}',
                              '#{pitch.x}',
                              '#{pitch.y}','#{pitch.start_speed}','#{pitch.end_speed}',
                              '#{pitch.sz_top}','#{pitch.sz_bot}','#{pitch.pfx_x}',
                              '#{pitch.pfx_z}','#{pitch.px}','#{pitch.pz}','#{pitch.x0}',
                              '#{pitch.y0}','#{pitch.z0}','#{pitch.vx0}','#{pitch.vy0}',
                              '#{pitch.vz0}','#{pitch.ax}','#{pitch.ay}','#{pitch.az}',
                              '#{pitch.break_y}','#{pitch.break_angle}','#{pitch.break_length}',
                              '#{pitch.on_1b}','#{pitch.on_2b}',
                              '#{pitch.on_3b}','#{pitch.sv_id}','#{pitch.pitch_type}',
                              '#{pitch.type_confidence}', '#{pitch.spin_dir}', '#{pitch.spin_rate}',
                              '#{Time.now}')")
      res = @db.query("select last_insert_id()")
      id = 0
      res.each do |row|
        id = row[0]
      end
      id
    end
    
    
    def insert_game(game, visitor_id, home_id)
      ump_hid = insert_umpire(game.get_umpires['home'])
      ump_1id = insert_umpire(game.get_umpires['first'])
      ump_2id = insert_umpire(game.get_umpires['second'])
      ump_3id = insert_umpire(game.get_umpires['third'])
      
      @db.query("INSERT INTO games (gid, date, home_id, away_id, game_num, umpire_hp_id, 
                                    umpire_1b_id, umpire_2b_id, umpire_3b_id, wind,
                                    wind_dir, temp, runs_home, runs_away, game_type, created_at)          
                    VALUES ('#{game.gid}', '#{Date.parse(game.get_date).to_s}', '#{home_id}', '#{visitor_id}',
                             '#{game.game_number}', '#{ump_hid}', '#{ump_1id}', '#{ump_2id}', 
                             '#{ump_3id}', '#{game.get_wind_speed}', '#{game.get_wind_dir}', 
                             '#{game.get_temp}', '#{game.get_home_runs}', '#{game.get_away_runs}',
                             '#{game.game_type}', '#{Time.now}') ")
                             
      res = @db.query("select id from games where gid='#{game.gid}'")
      id = 0
      res.each do |row|
        id = row[0]
      end
      id
    end
    
    
    def insert_umpire(umpire)
      name = @db.escape_string("#{umpire}")
      @db.query("INSERT INTO umpires (name, created_at)
                     VALUES ('#{name}', '#{Time.now}') ")                   
      res = @db.query("select last_insert_id()")
      id = 0
      res.each do |row|
        id = row[0]
      end
      id
    end
    
    
    def insert_pitch_type(pitch)
      @db.query("INSERT INTO pitch_types (abbreviation, description, created_at)
                     VALUES ('#{pitch.type}', '#{pitch.des}', '#{Time.now}') ")
      res = @db.query("select id from pitch_types where abbreviation='#{pitch.type}'")
      id = 0
      res.each do |row|
        id = row[0]
      end
      id
    end
    
    
    def insert_game_type(type)
      @db.query("INSERT INTO game_types (name, created_at)
                     VALUES ('#{type}', '#{Time.now}') ")
      res = @db.query("select id from game_types where name='#{type}'")
      id = 0
      res.each do |row|
        id = row[0]
      end
      id
    end
      
end