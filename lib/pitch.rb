
# This class represents a single pitch in an MLB baseball game.
# Most of the attributes represent the physics of the pitch thrown.
class Pitch
  
  attr_accessor :gid, :ab_num, :pitcher_id, :batter_id
  attr_accessor :des, :id, :type, :x, :y, :sv_id, :start_speed, :end_speed, :sz_top, :sz_bot, :pfx_x, :pfx_z, :px, :pz, :x0, :y0, :z0, :vx0, :vy0, :vz0
  attr_accessor :ax, :ay, :az, :break_y, :break_angle, :break_length, :pitch_type, :type_confidence, :spin_dir, :spin_rate
  
  def init(element, gid)
    
  end
  
end


