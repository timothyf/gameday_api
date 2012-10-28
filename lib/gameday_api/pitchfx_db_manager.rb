require 'rubygems'
require 'mysql2'
require 'gameday_api/pitching_line'


module GamedayApi

  # This class is used to insert data into the pitchfx database
  class PitchfxDbManager
  
  
      def initialize(host, user, password, db_name)
        @host = host
        @user = user
        @password = password
        @db_name = db_name
        @db = Mysql2::Client.new(:host => host, :username => user, :password => password, :database => db_name)
      end
    
    
      def find_or_create_player(player, team_id)
        res = @db.query("select id from players where gameday_id = #{player.pid}")
        id=0
      
        found = false
        res.each do |row|
          found = true
          id = row['id']
        end
        if !found
          id = insert_player(player, team_id)
        end
      
        id
      end
    
    
      def find_or_create_team(team)
        res = @db.query("select id from teams where abbreviation = '#{team.abrev}'")
        id=0
      
        found = false
        res.each do |row|
          found = true
          id = row['id']
        end
        if !found
          id = insert_team(team)
        end
        id
      end
    
    
      def find_or_create_game(game, visitor_id, home_id)
        res = @db.query("select id from games where gid = '#{game.gid}'")
        id=0
      
        found = false
        res.each do |row|
          found = true
          id = row['id']
        end
        if !found
          id = insert_game(game, visitor_id, home_id)
        end
        id
      end
    
    
      def find_or_create_atbat(atbat, game_id)
        res = @db.query("select id from atbats where game_id = #{game_id} and num = #{atbat.num}")
        id=0
      
        found = false
        res.each do |row|
          found = true
          id = row['id']
        end
        if !found
          id = insert_atbat(atbat, game_id)
        end
      
        id
      end
    
    
      def find_or_create_pitch(pitch, atbat_id)
        res = @db.query("select id from pitches where pitch_id = '#{pitch.pitch_id}' and atbat_id = '#{atbat_id}'")
        id=0
      
      
        found = false
        res.each do |row|
          found = true
          id = row['id']
        end
        if !found
          id = insert_pitch(pitch, atbat_id)
        end
      
        id
      end
    
    
      def find_or_create_umpire(name)
        ump_name = @db.escape(name)
        res = @db.query("select id from umpires where name = '#{ump_name}'")
        id=0
      
        found = false
        res.each do |row|
          found = true
          id = row['id']
        end
        if !found
          id = insert_umpire(name)
        end
            
        id
      end
    
    
      def find_or_create_pitch_type(type)
        res = @db.query("select id from pitch_types where id = #{type.id}")
        id=0
      
        found = false
        res.each do |row|
          found = true
          id = row['id']
        end
        if !found
           id = insert_pitch_type(type)
        end      

        id
      end
    
    
      def find_or_create_game_type(type)
        res = @db.query("select id from game_types where id = #{type.id}")
        id=0
      
        found = false
        res.each do |row|
          found = true
          id = row['id']
        end
        if !found
           id = insert_game_type(type)
        end
      
        id
      end
    
    
      def find_or_create_rosters(game, away_id, home_id)
        game_id = find_or_create_game(game, nil, nil)
        gameday_info = GamedayUtil.parse_gameday_id('gid_' + game.gid)
        active_date = "#{gameday_info['year']}/#{gameday_info['month']}/#{gameday_info['day']}"
        away_res = @db.query("select id from rosters where team_id = '#{away_id}' and active_date = '#{active_date}'")
        away_roster_id=0
      
        found = false
        away_res.each do |row|
          found = true
          away_roster_id = row['id']
        end
        if !found
           away_roster_id = insert_roster(game_id, away_id, active_date, 'a')
        end    

        home_res = @db.query("select id from rosters where team_id = '#{home_id}' and active_date = '#{active_date}'")
        home_roster_id=0
      
        found = false
        home_res.each do |row|
          found = true
          home_roster_id = row['id']
        end
        if !found
           home_roster_id = insert_roster(game_id, home_id, active_date, 'a')
        end
      
        [away_roster_id, home_roster_id]
      end
    
    
      def find_or_create_roster_player(player, roster_id) 
        res = @db.query("select id from players where gameday_id = #{player.pid}")
        player_id=0
        res.each do |row|
          player_id = row['id']
        end
        res = @db.query("select id from roster_players where roster_id = #{roster_id} and player_id = #{player_id}")
        id=0
      
        found = false
        res.each do |row|
          found = true
          id = row['id']
        end
        if !found
           id = insert_roster_player(roster_id, player, player_id)
        end
      
        id
      end
    
    
      def find_or_create_hip(hip, game)
        game_id = find_or_create_game(game, nil, nil)
        res = @db.query("select id from hips where game_id = #{game_id} and inning = #{hip.inning} and batter_id = #{hip.batter_id} and x=#{hip.x} and y=#{hip.y}")
        id=0
      
        found = false
        res.each do |row|
          found = true
          id = row['id']
        end
        if !found
           id = insert_hip(hip, game_id)
        end
        id
      end
    
    
      def find_or_create_game_infos(game)
        game_id = find_or_create_game(game, nil, nil)
        res = @db.query("select id from game_infos where game_id = #{game_id}")
        id=0
      
        found = false
        res.each do |row|
          found = true
          id = row['id']
        end
        if !found
           id = insert_game_info(game, game_id)
        end

        id
      end
    
    
      def find_or_create_linescore(linescore, game)
        game_id = find_or_create_game(game, nil, nil)
        inning_num = 1
        linescore.innings.each do |ls_inning|
          # ls_inning[0] => away runs
          # ls_inning[1] => home runs
          res = @db.query("select id from linescores where game_id = #{game_id} and inning = #{inning_num}")
          id=0 
      
          found = false
          res.each do |row|
            found = true
            id = row['id']
          end
          if !found
             id = insert_linescore(game_id, inning_num, ls_inning[0], ls_inning[1])
          end
              
          inning_num += 1
        end
      end
    
    
      def find_or_create_batting_stat(batter, game)
        game_id = find_or_create_game(game, nil, nil)
        res = @db.query("select id from players where gameday_id = #{batter.pid}")
        batter_id=0
        res.each do |row|
          batter_id = row['id']
        end
        res = @db.query("select id from batting_stats where game_id = #{game_id} and player_id = #{batter_id}")
        id=0
      
        found = false
        res.each do |row|
          found = true
          id = row['id']
        end
        if !found
          game_date = game.year + '/' + game.month + '/' + game.day
          id = insert_batting_stat(batter, game_id, game_date, batter_id)      
        end
        id 
      end
    
    
      def find_or_create_pitcher_line(pitcher, game)
        game_id = find_or_create_game(game, nil, nil)
        res = @db.query("select id from players where gameday_id = #{pitcher.pid}")
        pitcher_id=0
        res.each do |row|
          pitcher_id = row['id']
        end
        res = @db.query("select id from pitcher_lines where game_id = #{game_id} and pitcher_id = #{pitcher_id}")
        id=0
      
        found = false
        res.each do |row|
          found = true
          id = row['id']
        end
        if !found
           id = insert_pitcher_line(pitcher, game_id, pitcher_id)
        end
        id
      end
    
    
      def get_pitcher_line(line_id)
        @db.query("select id,game_id,pitcher_id,outs,er,r,h,so,hr,bb,w,l,era,note from pitcher_lines where id = #{line_id}")
      end
    
    
      def find_or_create_highlight(highlight, game)
        game_id = find_or_create_game(game, nil, nil)
        res = @db.query("select id from highlight_videos where game_id = #{game_id} and gameday_id = #{highlight.id}")
        id=0
      
        found = false
        res.each do |row|
          found = true
          id = row['id']
        end
        if !found
           id = insert_highlight(highlight, game_id)
        end
        id
      end
    
    
      def create_or_update_batting_stat(year, batter, game)
        game_id = find_or_create_game(game, nil, nil)
        res = @db.query("select id from players where gameday_id = #{batter.pid}")
        batter_id=0
        res.each do |row|
          batter_id = row['id']
        end 
        res = @db.query("select id from season_batting_stats where year = #{year} and batter_id = #{batter_id}")
        stat_id=0
      
        found = false
        res.each do |row|
          found = true
          stat_id = row['id']
        end
        if found
          id = update_season_batting_stat(batter, stat_id)
        else
           id = insert_season_batting_stat(year, batter_id, batter)
        end
      
        id
      end
    
    
      def create_or_update_pitching_stat(year, pitcher, game)
        # modify to get game date and then pass date into update_season_pitching_stat and insert_season_pitching_stat
        # this can be used to populate a last_update field
        game_id = find_or_create_game(game, nil, nil)
        res = @db.query("select id from players where gameday_id = #{pitcher.pid}")
        pitcher_id=0
        res.each do |row|
          pitcher_id = row['id']
        end
        res = @db.query("select id from season_pitching_stats where year = #{year} and pitcher_id = #{pitcher_id}")
        stat_id=0
      
        found = false
        res.each do |row|
          found = true
          stat_id = row['id']
        end
        if found
          line_id = find_or_create_pitcher_line(pitcher, game)
          line = PitchingLine.new
          line.init_from_db(line_id, self)
          id = update_season_pitching_stat(line, stat_id)
        else
          line_id = find_or_create_pitcher_line(pitcher, game)
          line = PitchingLine.new
          line.init_from_db(line_id, self)
          id = insert_season_pitching_stat(year, pitcher_id, line)
        end 
      
        id
      end
    
   
      def insert_season_batting_stat(year, batter_id, batter)
        @db.query("INSERT INTO season_batting_stats (year, batter_id, ab, h, avg, db, tr, hr, bb, k, rbi, hbp,
                      po, r, a, sf, err, lob, sb, created_at, updated_at)                                    
                   VALUES ('#{year}','#{batter_id}','#{batter.ab}','#{batter.h}', #{batter.avg},'#{batter.d}','#{batter.t}',
                           '#{batter.hr}','#{batter.bb}','#{batter.so}','#{batter.rbi}','#{batter.hbp}',
                           '#{batter.po}','#{batter.r}','#{batter.a}','#{batter.sf}','#{batter.e}','#{batter.lob}',
                           '#{batter.sb}',
                           '#{Time.now.strftime("%Y/%m/%d")}',
                           '#{Time.now.strftime("%Y/%m/%d")}')")
        res = @db.query("select last_insert_id()")
        id = 0
        res.each do |row|
          id = row['last_insert_id()']
        end
        id
      end
        
     
      def update_season_batting_stat(batter, stat_id)
        @db.query("UPDATE season_batting_stats SET ab=ab+#{batter.ab}, h=h+#{batter.h}, avg=#{batter.avg}, db=db+#{batter.d},
                            tr=tr+#{batter.t}, hr=hr+#{batter.hr}, bb=bb+#{batter.bb}, k=k+#{batter.so}, 
                            rbi=rbi+#{batter.rbi}, hbp=hbp+#{batter.hbp}, po=po+#{batter.po}, r=r+#{batter.r}, a=a+#{batter.a},
                            sf=sf+#{batter.sf}, err=err+#{batter.e}, lob=lob+#{batter.lob}, sb=sb+#{batter.sb},
                            updated_at='#{Time.now.strftime("%Y/%m/%d")}' 
                    WHERE id=#{stat_id}")
      end
    
    
      def insert_season_pitching_stat(year, pitcher_id, line)
        @db.query("INSERT INTO season_pitching_stats (year, pitcher_id, w, l, s, outs, r, er, h, hr, bb, k, 
                                                      era, pitches, created_at, updated_at) 
                   VALUES ('#{year}','#{pitcher_id}','#{line.w}','#{line.l}', NULL,'#{line.outs}','#{line.r}',
                           '#{line.er}','#{line.h}', 
                           '#{line.hr}','#{line.bb}','#{line.so}','#{line.era}',NULL,
                           '#{Time.now.strftime("%Y/%m/%d")}',
                           '#{Time.now.strftime("%Y/%m/%d")}')")
        res = @db.query("select last_insert_id()")
        id = 0
        res.each do |row|
          id = row['last_insert_id()']
        end
        id
      end
    
    
      def update_season_pitching_stat(line, stat_id)
        @db.query("UPDATE season_pitching_stats SET w=#{line.w}, l=#{line.l}, outs=outs+#{line.outs}, r=r+#{line.r}, 
                    er=er+#{line.er}, h=h+#{line.h}, hr=hr+#{line.hr}, bb=bb+#{line.bb}, k=k+#{line.so}, era=#{line.era},
                    updated_at='#{Time.now.strftime("%Y/%m/%d")}' 
                    WHERE id=#{stat_id}")
      end
    
    
      def insert_roster(game_id, team_id, active_date, home_or_away)
        @db.query("INSERT INTO rosters (team_id, active_date, game_id, home_or_away, created_at) 
                   VALUES ('#{team_id}','#{active_date}', '#{game_id}', '#{home_or_away}', '#{Time.now.strftime("%Y/%m/%d")}')")
        res = @db.query("select last_insert_id()")
        id = 0
        res.each do |row|
          id = row['last_insert_id()']
        end
        id
      end
    
    
      # Used to set game_id and home_or_away flag
      def update_rosters(game, away_id, home_id)
        game_id = find_or_create_game(game, nil, nil)
      
        gameday_info = GamedayUtil.parse_gameday_id('gid_' + game.gid)
        active_date = "#{gameday_info['year']}/#{gameday_info['month']}/#{gameday_info['day']}"
      
        away_res = @db.query("select id from rosters where team_id = '#{away_id}' and active_date = '#{active_date}'")
        away_roster_id=0
      
        found = false
        away_res.each do |row|
          found = true
          away_roster_id = row['id']
        end

        @db.query("UPDATE rosters SET game_id = '#{game_id}', home_or_away = 'a' WHERE id = '#{away_roster_id}'")

        home_res = @db.query("select id from rosters where team_id = '#{home_id}' and active_date = '#{active_date}'")
        home_roster_id=0
      
      
        found = false
        home_res.each do |row|
          found = true
          home_roster_id = row['id']
        end
      
        @db.query("UPDATE rosters SET game_id = '#{game_id}', home_or_away = 'h' WHERE id = '#{home_roster_id}'")
      end
    
    
      def insert_roster_player(roster_id, player, player_id)
        @db.query("INSERT INTO roster_players (roster_id, player_id, number, position, status, avg, hr, rbi,
                                               wins, losses, era, bat_order, game_position, created_at) 
                   VALUES ('#{roster_id}',
                           '#{player_id}', 
                           '#{player.num}',
                           '#{player.position}',
                           '#{player.status}',
                           '#{player.avg}',
                           '#{player.hr}',
                           '#{player.rbi}',
                           '#{player.wins}',
                           '#{player.losses}',
                           '#{player.era}',
                           '#{player.bat_order}',
                           '#{player.game_position}',
                           '#{Time.now.strftime("%Y/%m/%d")}')")
        res = @db.query("select last_insert_id()")
        id = 0
        res.each do |row|
          id = row['last_insert_id()']
        end
        id
      end
    
    
      def insert_hip(hip, game_id)
        @db.query("INSERT INTO hips (des, x, y, batter_id, pitcher_id, hip_type, team, inning, game_id, created_at) 
                    VALUES ('#{hip.des}','#{hip.x}','#{hip.y}','#{hip.batter_id}','#{hip.pitcher_id}','#{hip.hip_type}',
                            '#{hip.team}','#{hip.inning}','#{game_id}','#{Time.now.strftime("%Y/%m/%d")}')")
        res = @db.query("select last_insert_id()")
        id = 0
        res.each do |row|
          id = row['last_insert_id()']
        end
        id
      end
    
    
      def insert_game_info(game, game_id)
        boxscore = game.get_boxscore
        home_text = @db.escape("#{boxscore.home_batting_text}")
        away_text = @db.escape("#{boxscore.away_batting_text}")
        info_text = @db.escape("#{boxscore.game_info}")
        away_runs = boxscore.away_runs
        home_runs = boxscore.home_runs
        away_hits = boxscore.linescore.away_team_hits
        home_hits = boxscore.linescore.home_team_hits
        away_errors = boxscore.linescore.away_team_errors
        home_errors = boxscore.linescore.home_team_errors
        @db.query("INSERT INTO game_infos (game_id, home_text, away_text, info_text, away_runs, home_runs,
                                  away_hits, home_hits, away_errors, home_errors, created_at) 
                    VALUES ('#{game_id}','#{home_text}','#{away_text}','#{info_text}','#{away_runs}','#{home_runs}',
                            '#{away_hits}', '#{home_hits}', '#{away_errors}', '#{home_errors}','#{Time.now.strftime("%Y/%m/%d")}')")
        res = @db.query("select last_insert_id()")
        id = 0
        res.each do |row|
          id = row['last_insert_id()']
        end
        id
      end
    
    
      def insert_linescore(game_id, inning, away_runs, home_runs)
        @db.query("INSERT INTO linescores (game_id, inning, away_runs, home_runs, created_at) 
                    VALUES ('#{game_id}','#{inning}','#{away_runs}','#{home_runs}','#{Time.now.strftime("%Y/%m/%d")}')")
        res = @db.query("select last_insert_id()")
        id = 0
        res.each do |row|
          id = row['last_insert_id()']
        end
        id
      end

    
      def insert_batting_stat(batter, game_id, game_date, batter_id)
        name = @db.escape("#{batter.batter_name}")
        @db.query("INSERT INTO batting_stats (player_id, gameday_id, game_id, game_date, name, pos, bo, ab, po, r, bb, 
                      a, tr, sf, h, err, db, hbp, k, hr, rbi, lob, fldg, sb, s_hr, s_rbi, avg, created_at) 
                     VALUES ('#{batter_id}', '#{batter.pid}', '#{game_id}', '#{game_date}', '#{name}','#{batter.pos}', 
                             '#{batter.bo}','#{batter.ab}','#{batter.po}','#{batter.r}','#{batter.bb}','#{batter.a}',
                             '#{batter.t}','#{batter.sf}','#{batter.h}','#{batter.e}','#{batter.d}','#{batter.hbp}',
                             '#{batter.so}','#{batter.hr}','#{batter.rbi}','#{batter.lob}','#{batter.fldg}','#{batter.sb}',
                             '#{batter.s_hr}','#{batter.s_rbi}','#{batter.avg}','#{Time.now.strftime("%Y/%m/%d")}')")
        res = @db.query("select last_insert_id()")
        id = 0
        res.each do |row|
          id = row['last_insert_id()']
        end
        id
      end
    
    
      def insert_pitcher_line(pitcher, game_id, pitcher_id)
        #puts "INSERT INTO pitcher_lines (game_id, pitcher_id, name, pos, outs, bf, er, r, h, so, hr, bb, w, l, era, note) 
        #              VALUES ('#{game_id}', '#{pitcher_id}','#{pitcher.pitcher_name}','P', '#{pitcher.out}',
        #                     '#{pitcher.bf}','#{pitcher.er}','#{pitcher.r}','#{pitcher.h}','#{pitcher.so}','#{pitcher.hr}',
        #                     '#{pitcher.bb}','#{pitcher.w}','#{pitcher.l}','#{pitcher.era}','#{pitcher.note}')"
       name = @db.escape("#{pitcher.pitcher_name}")                    
       @db.query("INSERT INTO pitcher_lines (game_id, pitcher_id, name, pos, outs, bf, er, r, h, so, hr, bb, w, l, era, note) 
                    VALUES ('#{game_id}', '#{pitcher_id}','#{name}','P', '#{pitcher.out}','#{pitcher.bf}',
                            '#{pitcher.er}','#{pitcher.r}','#{pitcher.h}','#{pitcher.so}','#{pitcher.hr}','#{pitcher.bb}',
                            '#{pitcher.w}','#{pitcher.l}','#{pitcher.era}','#{pitcher.note}')")
       res = @db.query("select last_insert_id()")
       id = 0
       res.each do |row|
         id = row['last_insert_id()']
       end
       id
      end
      
    
      def insert_player(player, team_id)
        first = @db.escape("#{player.first}")
        last = @db.escape("#{player.last}")
        boxname = @db.escape("#{player.boxname}")
        @db.query("INSERT INTO players (team_id, gameday_id, first, last, number, boxname, position, throws) 
                     VALUES ('#{team_id}', '#{player.pid}','#{first}','#{last}',
                             '#{player.num}','#{boxname}','#{player.position}',
                             '#{player.rl}')")
        res = @db.query("select last_insert_id()")
        id = 0
        res.each do |row|
          id = row['last_insert_id()']
        end
        id
      end
      
    
      def insert_team(team)
        @db.query("INSERT INTO teams (abbreviation, city, name, stadium, created_at) 
                              VALUES ('#{team.abrev}', '#{team.city}','#{team.name}','', '#{Time.now.strftime("%Y/%m/%d")}')")
        res = @db.query("select id from teams where name='#{team.name}'")
        id = 0
        res.each do |row|
          id = row['id']
        end
        id
      end
    
    
      def insert_atbat(atbat, game_id)
        desc = @db.escape("#{atbat.des}")
        @db.query("INSERT INTO atbats (game_id, inning, num, ball, strike, outs, batter_id,
               pitcher_id, stand, des, event, created_at) 
              VALUES ('#{game_id}','#{atbat.inning}','#{atbat.num}','#{atbat.b}','#{atbat.s}',
                      '#{atbat.o}','#{atbat.batter_id}','#{atbat.pitcher_id}','#{atbat.stand}',
                      '#{desc}','#{atbat.event}', '#{Time.now.strftime("%Y/%m/%d")}')")
        res = @db.query("select last_insert_id()")
        id = 0
        res.each do |row|
          id = row['last_insert_id()']
        end
        id
      end
    
    
      def insert_pitch(pitch, atbat_id)
        batter_id = nil
        pitcher_id = nil
        # lookup atbat for this pitch
        res1 = @db.query("select batter_id, pitcher_id from atbats where id=#{atbat_id}")
        res1.each do |row|
          batter_id = row['batter_id']
          pitcher_id = row['pitcher_id']
        end
      
        @db.query("INSERT INTO pitches (atbat_id, pitch_id, description, outcome, x, y, start_speed, end_speed,
                        sz_top, sz_bot, pfx_x, pfx_z, px, pz, x0, y0, z0, vx0, vy0, vz0, ax, ay, az,
                        break_y, break_angle, break_length, on_1b, on_2b, on_3b,
                        sv_id, pitch_type, type_confidence, spin_dir, spin_rate, batter_id, pitcher_id, created_at) 
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
                                '#{batter_id}','#{pitcher_id}',
                                '#{Time.now.strftime("%Y/%m/%d")}')")
        res = @db.query("select last_insert_id()")
        id = 0
        res.each do |row|
          id = row['last_insert_id()']
        end
        id
      end
    
    
      def insert_game(game, visitor_id, home_id)
        ump_hid = find_or_create_umpire(game.get_umpires['home'])
        ump_1id = find_or_create_umpire(game.get_umpires['first'])
        ump_2id = find_or_create_umpire(game.get_umpires['second'])
        ump_3id = find_or_create_umpire(game.get_umpires['third'])
      
        if game.get_home_runs.to_i > game.get_away_runs.to_i
          winning_team_id = home_id
          losing_team_id = visitor_id
        elsif game.get_home_runs.to_i < game.get_away_runs.to_i
          winning_team_id = visitor_id
          losing_team_id = home_id
        end
      
        @db.query("INSERT INTO games (gid, date, home_id, away_id, game_num, umpire_hp_id, 
                                      umpire_1b_id, umpire_2b_id, umpire_3b_id, wind,
                                      wind_dir, temp, runs_home, runs_away, game_type, status, 
                                      winning_team_id, losing_team_id, created_at)          
                      VALUES ('#{game.gid}', '#{Date.parse(game.get_date).to_s}', '#{home_id}', '#{visitor_id}',
                               '#{game.game_number}', '#{ump_hid}', '#{ump_1id}', '#{ump_2id}', 
                               '#{ump_3id}', '#{game.get_wind_speed}', '#{game.get_wind_dir}', 
                               '#{game.get_temp}', '#{game.get_home_runs}', '#{game.get_away_runs}',
                               '#{game.game_type}', '#{game.get_boxscore.status_ind}', 
                               '#{winning_team_id}', '#{losing_team_id}', '#{Time.now.strftime("%Y/%m/%d")}') ")
                             
        res = @db.query("select id from games where gid='#{game.gid}'")
        id = 0
        res.each do |row|
          id = row['id']
        end
        id
      end
    
    
      def update_status_for_game(game)
        @db.query("UPDATE games SET status='#{game.get_boxscore.status_ind}' WHERE gid='#{game.gid}'")
      end
    
    
      def insert_umpire(umpire)
        name = @db.escape(umpire)
        @db.query("INSERT INTO umpires (name, created_at)
                       VALUES ('#{name}', '#{Time.now.strftime("%Y/%m/%d")}') ")                   
        res = @db.query("select last_insert_id()")
        id = 0
        res.each do |row|
          id = row['last_insert_id()']
        end
        id
      end
    
    
      def insert_pitch_type(pitch)
        @db.query("INSERT INTO pitch_types (abbreviation, description, created_at)
                       VALUES ('#{pitch.type}', '#{pitch.des}', '#{Time.now.strftime("%Y/%m/%d")}') ")
        res = @db.query("select id from pitch_types where abbreviation='#{pitch.type}'")
        id = 0
        res.each do |row|
          id = row['id']
        end
        id
      end
    
    
      def insert_game_type(type)
        @db.query("INSERT INTO game_types (name, created_at)
                       VALUES ('#{type}', '#{Time.now.strftime("%Y/%m/%d")}') ")
        res = @db.query("select id from game_types where name='#{type}'")
        id = 0
        res.each do |row|
          id = row['id']
        end
        id
      end
    
    
      def insert_highlight(highlight, game_id)
        headline = name = @db.escape(highlight.headline)
        @db.query("INSERT INTO highlight_videos (game_id, gameday_id, highlight_date, headline, duration, thumb_url, 
                                                 res_400_url, res_500_url, res_800_url, created_at) 
                     VALUES ('#{game_id}', '#{highlight.id}','#{highlight.date}','#{headline}',
                             '#{highlight.duration}','#{highlight.thumb_url}','#{highlight.res_400_url}',
                             '#{highlight.res_500_url}','#{highlight.res_800_url}','#{Time.now.strftime("%Y/%m/%d")}')")
        res = @db.query("select last_insert_id()")
        id = 0
        res.each do |row|
          id = row['last_insert_id()']
        end
        id
      end
    
    
      # Update the game records to point to the first instance of the specific umpires
      # originally new umpire records were being inserted for every game, which is what caused this problem
      def update_umpire_ids_for_games
        ump_id_hp = nil
        ump_id_1b = nil
        ump_id_2b = nil
        ump_id_3b = nil
        res = @db.query("select id, umpire_hp_id, umpire_1b_id, umpire_2b_id, umpire_3b_id from games")
        res.each do |row| # each game
          game_id = row[0]
          umpire_hp_id = row['umpire_hp_id']
          umpire_1b_id = row['umpire_1b_id']
          umpire_2b_id = row['umpire_2b_id']
          umpire_3b_id = row['umpire_3b_id']
        
          # look up umpire record for hp ump
          ump_id_hp = get_first_occurance_of_umpire(umpire_hp_id)
          ump_id_1b = get_first_occurance_of_umpire(umpire_1b_id)
          ump_id_2b = get_first_occurance_of_umpire(umpire_2b_id)
          ump_id_3b = get_first_occurance_of_umpire(umpire_3b_id)
        
          # update game with correct ump ids
          @db.query("UPDATE games SET umpire_hp_id='#{ump_id_hp}',umpire_1b_id='#{ump_id_1b}',
                       umpire_2b_id='#{ump_id_2b}', umpire_3b_id='#{ump_id_3b}' WHERE id=#{game_id}")
        end
      end
    
    
      def get_first_occurance_of_umpire(id)
        ump_id = nil
        uh_res = @db.query("select id, name from umpires where id=#{id}")
        uh_res.each do |row|
          id = row['id']
          name = row['name']
          res = @db.query("select id from umpires where name=#{name}")
          res.each do |row|
            if !ump_id # only set id on first result
              ump_id = row['id']
            end
          end
        end
        return ump_id
      end
    
    
      def import_pitch_relations
        # select all pitches from pitchfx db
        res = @db.query("select id, batter_id, pitcher_id, atbat_id, pitch_type from pitches")
        res.each do |row|
          pitch_id = row['id']
          batter_id = row['batter_id']
          pitcher_id = row['pitcher_id']
          atbat_id = row['atbat_id']
          pitch_type = row['pitch_type']
        
          # find atbat for this pitch
          a_res = @db.query("select game_id, inning from atbats where id=#{atbat_id}")
          a_res.each do |row|
            game_id = row['game_id']
            inning = row['inning']
          
            # find game for this pitch
            g_res = @db.query("select away_id, home_id, date from games where id=#{game_id}")
            g_res.each do |row|
              away_id = row['away_id']
              home_id = row['home_id']
              date = row['date']
            
              # insert pitch relation
              @db.query("INSERT INTO pitch_relations (pitch_id, pitch_type, pitcher_id, batter_id, atbat_id, game_id, away_id, 
                                                      home_id, game_date, inning, created_at)
                             VALUES ('#{pitch_id}','#{pitch_type}','#{pitcher_id}','#{batter_id}','#{atbat_id}',
                                     '#{game_id}','#{away_id}','#{home_id}','#{date}','#{inning}',
                                     '#{Time.now.strftime("%Y/%m/%d")}') ")
            
            end
          end
        end
      end
    
    
      def update_pitches_with_batter_pitcher
        # select all atbats from pitchfx db
        res = @db.query("select id, batter_id, pitcher_id from atbats")
        res.each do |row|
          atbat_id = row['id']
          batter_id = row['batter_id']
          pitcher_id = row['pitcher_id']
        
          # look up pitches for this atbat
          p_res = @db.query("select id from pitches where atbat_id=#{atbat_id}")
          p_res.each do |row|
            pitch_id = row['id']
          
            # update pitch with new fields
            @db.query("UPDATE pitches SET batter_id='#{batter_id}',pitcher_id='#{pitcher_id}' WHERE id=#{pitch_id}")
          end
        end
      end
    
    
      def add_player_data(lahman_dbname)
        @lahman_db = Mysql2::Client.new(:host => @host, :username => @user, :password => @password, :database => lahman_dbname)
      
      
        # select all players from pitchfx db
        res = @db.query("select id, first, last from players")
          res.each do |row|
            player_id = row['id']
            first = @db.escape(row['first'])
            last = @db.escape(row['last'])
          
            # lookup player by first and last in lahman_db
            lres = @lahman_db.query("select bats, birthYear, birthMonth, birthDay, birthCountry, debut, 
                                     college from Master where nameFirst = '#{first}' and nameLast = '#{last}'")
              bats = nil
              birthYear = nil
              birthMonth = nil
              birthDay = nil
              birthCountry = nil
              debut = nil
              college = nil
              lres.each do |row|
                bats = row['bats']
                birthYear = row['birthYear']
                birthMonth = row['birthMonth']
                birthDay = row['birthDay']
                if row['birthCountry']
                  birthCountry = @db.escape(row['birthCountry'])
                end
                debut = row['debut']
                if row['college']
                  college = @db.escape(row['college'])
                end
              end
              
              # update player record with new fields from lahman_db data
              @db.query("UPDATE players set bats='#{bats}', birth_year='#{birthYear}', birth_month='#{birthMonth}', 
                                birth_day='#{birthDay}',
                                birth_country='#{birthCountry}', debut='#{debut}', college='#{college}' WHERE id=#{player_id}")
          end
      end
  end
      
end