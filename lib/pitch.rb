
# This class represents a single pitch in an MLB baseball game.
# Most of the attributes represent the physics of the pitch thrown.
#
# Pitch Type Codes
#   FS = Splitter
#   SL = Slider
#   FF = Fastball
#   SI = Sinker
#   CH = Change
#   FA = Fastball
#   CU = Curve
#   FC = Cutter
#   KN = Knuckle
#   KC = Knuckle Curve
#
class Pitch
  
  attr_accessor :gid, :ab_num, :pitcher_id, :batter_id
  attr_accessor :des, :id, :type, :x, :y, :sv_id, :start_speed, :end_speed
  attr_accessor :sz_top, :sz_bot, :pfx_x, :pfx_z, :px, :pz, :x0, :y0, :z0, :vx0, :vy0, :vz0
  attr_accessor :ax, :ay, :az, :break_y, :break_angle, :break_length, :pitch_type, :type_confidence
  attr_accessor :spin_dir, :spin_rate
  
  def init(element)
    @des = element.attributes["des"]
    @id = element.attributes["id"]
    @type = element.attributes["type"]
    @x = element.attributes["x"]
    @y = element.attributes["y"]
    @sv_id = element.attributes["sv_id"]
    @start_speed = element.attributes["start_speed"]
    @end_speed = element.attributes["end_speed"]
    @sz_top = element.attributes["sz_top"]
    @sz_bot = element.attributes["sz_bot"]
    @pfx_x = element.attributes["pfx_x"]
    @pfx_z = element.attributes["pfx_z"]
    @px = element.attributes["px"]
    @pz = element.attributes["pz"]
    @x0 = element.attributes["x0"]
    @y0 = element.attributes["y0"]
    @z0 = element.attributes["z0"]
    @vx0 = element.attributes["vx0"]
    @vy0 = element.attributes["vy0"]
    @vz0 = element.attributes["vz0"]
    @ax = element.attributes["ax"]
    @ay = element.attributes["ay"]
    @az = element.attributes["az"]
    @break_y = element.attributes["break_y"]
    @break_angle = element.attributes["break_angle"]
    @break_length = element.attributes["break_length"]
    @pitch_type = element.attributes["pitch_type"]
    @type_confidence = element.attributes["type_confidence"]
    @spin_dir = element.attributes["spin_dir"]
    @spin_rate = element.attributes["spin_rate"]
  end
  
  
  def self.get_pitch_name(code)
    case code
    when 'FS'
      'Splitter'
    when 'SL'
      'Slider'
    when 'FF'
      'Fastball' # 4 seam
    when 'FT'
      'Fastball' # 2 seam
    when 'SI'
      'Sinker'
    when 'CH'
      'Change'
    when 'FA'
      'Fastball'
    when 'CU'
      'Curve'
    when 'FC'
      'Cutter'
    when 'KN'
      'Knuckle'
    when 'KC'
      'Knuckle Curve'
    else
      code
    end
  end
  
end

