require 'rexml/document'


module GamedayApi

  # This class parses various Gameday data files
  # This works with Rails and ActiveRecord
  class GamedayParser
	
  	def self.parse_player_data(doc, team, logger)
  		updated_player_count = 0
  		new_player_count = 0
  		doc.root.each_element do |player|
  			gameday_id = player.attributes['id']
  			if (gameday_id)
  				old_player = Player.find(:first, :conditions=>'gameday_id='+gameday_id)
  				if old_player
  					# update player	
  					old_player.first_name = player.attributes['first']
  					old_player.last_name = player.attributes['last']
  					old_player.position = player.attributes['pos']
  					old_player.team_id = team.id
  					old_player.save
  					updated_player_count = updated_player_count+1
  				else
  					# create player	
  					Player.create(:gameday_id => gameday_id, 
  								  :first_name => player.attributes['first'], 
  								  :last_name => player.attributes['last'], 
  								  :position => player.attributes['pos'], 
  								  :team_id => team.id)
  					new_player_count = new_player_count+1
  				end
  			end
  		end	
  		logger.info "Team: #{team.name}"
  		logger.info "Updated Players: #{updated_player_count}"
  		logger.info "New Players: #{new_player_count}"
  		puts "Completed #{team.name}"
  	end
	
	
  	def self.parse_pitcher_game_data(doc, game, logger)
  		player = doc.root
  		gameday_id = player.attributes['id']
  		if (gameday_id)
  			team_abbrev = player.attributes['team']
  			team = Team.find(:first, :conditions=>"abbreviation='#{team_abbrev}'")
  			old_player = Player.find(:first, :conditions=>'gameday_id='+gameday_id)
  			if old_player
  				# update player	
  				old_player.first_name = player.attributes['first_name']
  				old_player.last_name = player.attributes['last_name']
  				old_player.position = player.attributes['pos']
  				old_player.jersey_number = player.attributes['jersey_number'].to_i
  				old_player.height = player.attributes['height']
  				old_player.weight = player.attributes['weight'].to_i
  				old_player.bats = player.attributes['bats']
  				old_player.throws = player.attributes['throws']
  				#old_player.birthdate = player.attributes['dob']
  				old_player.team_id = team.id
  				old_player.save
  			else
  				# create player	
  				Player.create(:gameday_id => gameday_id, 
  							  :first_name => player.attributes['first_name'], 
  							  :last_name => player.attributes['last_name'], 
  							  :position => player.attributes['pos'], 
  							  :jersey_number => player.attributes['jersey_number'].to_i, 
  							  :height => player.attributes['height'], 
  							  :weight => player.attributes['weight'].to_i, 
  							  :bats => player.attributes['bats'], 
  							  :throws => player.attributes['throws'],
  							  #:birthdate => player.attributes['dob'], 
  							  :team_id => team.id)
  			end
  		end	
  	end
	
	
  	def self.parse_scoreboard_data(doc, game)
  		doc.root.each_element do |scoreboard_element|
  			if scoreboard_element.name == 'post_game'
  				scoreboard_element.each_element do |post_game_element|
  					if post_game_element.name == 'winning_pitcher'
  						gd_id = post_game_element.attributes['id']
  						player = Player.find(:first, :conditions=>"gameday_id=#{gd_id}")
  						if (player) 
  							game.update_attribute(:winning_pitcher_id, player.id)
  						end
  					elsif post_game_element.name == 'losing_pitcher'
  						gd_id = post_game_element.attributes['id']
  						player = Player.find(:first, :conditions=>"gameday_id=#{gd_id}")
  						if (player) 
  							game.update_attribute(:losing_pitcher_id, player.id)
  						end
  					elsif post_game_element.name == 'save_pitcher'
  						gd_id = post_game_element.attributes['id']
  						player = Player.find(:first, :conditions=>"gameday_id=#{gd_id}")
  						if (player) 
  							game.update_attribute(:save_pitcher_id, player.id)
  						end
  					end
  				end
  			end
  		end
  	end
	
	
  	def self.parse_inning_hip_data(doc, game_id)
  		if !doc.root
  			return
  		end
  		doc.root.each_element do |hip|
  			begin
  				batter = Player.find(:first, :conditions=>'gameday_id='+hip.attributes['batter'])
  				pitcher = Player.find(:first, :conditions=>'gameday_id='+hip.attributes['pitcher'])
  				hit = Hit.new
  				hit.description = hip.attributes['des']
  				hit.x = hip.attributes['x']
  				hit.y = hip.attributes['y']
  				if batter
  					hit.batter_id = batter.id
  				end
  				if pitcher
  					hit.pitcher_id = pitcher.id
  				end
  				hit.gd_type = hip.attributes['type']
  				hit.team = hip.attributes['team']
  				hit.inning = hip.attributes['inning']
  				hit.game_id = game_id
  				hit.save
  			end
  		end
  	end
	
	
  	def self.parse_innings_ab_data(doc, game_id)
  		if !doc
  			return
  		end
  		current_atbat=0
  		current_order=0
  		inning = doc.root.attributes['num']
  		doc.root.each_element do |inning_half|
  			begin
  				half = inning_half.name
  				inning_half.each_element do |atbat_action|
  					current_order = current_order+1
  					if atbat_action.name == 'atbat'
  						batter = Player.find(:first, :conditions=>'gameday_id='+atbat_action.attributes['batter'])
  						pitcher = Player.find(:first, :conditions=>'gameday_id='+atbat_action.attributes['pitcher'])
  						atbat = AtBat.new
  						atbat.inning = inning
  						atbat.half = half
  						atbat.number = atbat_action.attributes['num']
  						current_atbat = atbat.number
  						atbat.ball = atbat_action.attributes['b']
  						atbat.strike = atbat_action.attributes['s']
  						atbat.out = atbat_action.attributes['o']
  						atbat.batter_gd_id = atbat_action.attributes['batter']
  						atbat.pitcher_gd_id = atbat_action.attributes['pitcher']
  						atbat.stand = atbat_action.attributes['stand']
  						atbat.description = atbat_action.attributes['des']
  						atbat.event = atbat_action.attributes['event']
  						if batter
  							atbat.batter_id = batter.id
  						end
  						if pitcher
  							atbat.pitcher_id = pitcher.id
  						end
  						atbat.game_id = game_id
  						atbat.order = current_order
  						atbat.gd_type = 'atbat'
  						atbat.save
  						atbat_action.each_element do |pitch_runner|
  							if pitch_runner.name == 'pitch'
  								pitch = Pitch.new
  								pitch.at_bat_id = atbat.id
  								pitch.description = pitch_runner.attributes['des']	
  								pitch.pitch_type = pitch_runner.attributes['type']
  								pitch.gd_pitch_id = pitch_runner.attributes['id']
  								pitch.x = pitch_runner.attributes['x']
  								pitch.y = pitch_runner.attributes['y']
  								pitch.on_1b = pitch_runner.attributes['on_1b']
  								pitch.on_2b = pitch_runner.attributes['on_2b']
  								pitch.on_3b = pitch_runner.attributes['on_3b']
  								pitch.save
  							elsif pitch_runner.name == 'runner'
  								runner = Runner.new
  								player = Player.find(:first, :conditions=>"gameday_id=#{pitch_runner.attributes['id']}")
  								runner.player_id = player.id
  								runner.start = pitch_runner.attributes['start']
  								runner.end = pitch_runner.attributes['end']
  								runner.event = pitch_runner.attributes['event']
  								runner.score = pitch_runner.attributes['score']
  								runner.rbi = pitch_runner.attributes['rbi']
  								runner.earned = pitch_runner.attributes['earned']
  								runner.at_bat_id = atbat.id
  								runner.save
  							end
  						end
  					elsif atbat_action.name == 'action'
  						action = AtBat.new
  						action.ball = atbat_action.attributes['b']
  						action.strike = atbat_action.attributes['s']
  						action.out = atbat_action.attributes['o']
  						action.description = atbat_action.attributes['des']
  						action.event = atbat_action.attributes['event']
  						action.pitch = atbat_action.attributes['pitch']
  						action.score = atbat_action.attributes['score']
  						action.game_id = game_id					
  						player = Player.find(:first, :conditions=>"gameday_id=#{atbat_action.attributes['player']}")
  						action.player_id = player.id
  						action.inning = inning
  						action.half = half
  						action.order = current_order
  						action.gd_type = 'action'
  						# action.next_atbat = current_atbat + 1
  						action.save
  					end
  				end
  			end
  		end
  	end
	
	
  	def self.parse_event_log_data(doc, game_id)
  		doc.root.each_element do |team|
  			team_id = team.attributes['id']
  			team.each_element do |event|
  				event_obj = Event.new
  				event_obj.number = event.attributes['number']
  				event_obj.inning = event.attributes['inning']
  				event_obj.description = event.attributes['description']	
  				event_obj.team_id = team_id
  				event_obj.game_id = game_id
  				event_obj.save
  			end
  		end
  	end
	
	
  	def self.parse_batter_pbp_data(doc, game)
  		doc.root.each_element do |atbat|
  			batter = Player.find(:first, :conditions=>'gameday_id='+atbat.attributes['batter'])
  			pitcher = Player.find(:first, :conditions=>'gameday_id='+atbat.attributes['pitcher'])

  			existing_ab = AtBat.find(:first, :conditions=>"game_id=#{game.id} AND inning=#{atbat.attributes['inning']} AND number=#{atbat.attributes['num']}")
  			if !existing_ab
  				at_bat_obj = AtBat.new
  				at_bat_obj.inning = atbat.attributes['inning']
  				at_bat_obj.number = atbat.attributes['num']
  				at_bat_obj.ball = atbat.attributes['b']
  				at_bat_obj.strike = atbat.attributes['s']
  				at_bat_obj.out = atbat.attributes['o']
  				at_bat_obj.batter_gd_id = atbat.attributes['batter']
  				at_bat_obj.pitcher_gd_id = atbat.attributes['pitcher']
  				at_bat_obj.stand = atbat.attributes['stand']
  				at_bat_obj.description = atbat.attributes['des']
  				at_bat_obj.event = atbat.attributes['event']
  				at_bat_obj.brief_event = atbat.attributes['brief_event']
  				at_bat_obj.batter_id = batter.id
  				at_bat_obj.pitcher_id = pitcher.id
  				at_bat_obj.game_id = game.id
  				at_bat_obj.save
				
  				atbat.each_element do |pitch|
  					pitch_obj = Pitch.new
  					pitch_obj.at_bat_id = at_bat_obj.id
  					pitch_obj.description = pitch.attributes['des']	
  					pitch_obj.pitch_type = pitch.attributes['type']
  					pitch_obj.gd_pitch_id = pitch.attributes['id']
  					pitch_obj.x = pitch.attributes['x']
  					pitch_obj.y = pitch.attributes['y']
  					if pitch.attributes['start_speed']
  						pitch_obj.start_speed = pitch.attributes['start_speed']
  						pitch_obj.end_speed = pitch.attributes['end_speed']
  						pitch_obj.sz_top = pitch.attributes['sz_top']
  						pitch_obj.sz_bot = pitch.attributes['sz_bot']
  						pitch_obj.pfx_x = pitch.attributes['pfx_x']
  						pitch_obj.pfx_z = pitch.attributes['pfx_z']
  						pitch_obj.px = pitch.attributes['px']
  						pitch_obj.pz = pitch.attributes['pz']
  						pitch_obj.x0 = pitch.attributes['x0']
  						pitch_obj.y0 = pitch.attributes['y0']
  						pitch_obj.z0 = pitch.attributes['z0']
  						pitch_obj.vx0 = pitch.attributes['vx0']
  						pitch_obj.vy0 = pitch.attributes['vy0']
  						pitch_obj.vz0 = pitch.attributes['vz0']
  						pitch_obj.ax = pitch.attributes['ax']
  						pitch_obj.ay = pitch.attributes['ay']
  						pitch_obj.az = pitch.attributes['az']
  						pitch_obj.break_y = pitch.attributes['break_y']
  						pitch_obj.break_angle = pitch.attributes['break_angle']
  						pitch_obj.break_length = pitch.attributes['break_length']
  						pitch_obj.at_bat_id = at_bat_obj.id
  					end
  					pitch_obj.save
  				end
  			else
  				#puts "At bat already exists..."	
  			end
  		end	
  	end
  end
end
