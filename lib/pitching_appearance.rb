
# This class holds data that represents a single pitching appearance by a pitcher.
class PitchingAppearance
  
  attr_accessor :pid, :pitcher_name, :out, :inn, :er, :r, :h, :so, :hr, :bb, :w, :l, :era, :note, :start
  
  
  # Used to initialize from box score data
  def init(element, count)
      self.pid                  = element.attributes['id']
      self.pitcher_name  = element.attributes['name']
      self.out               = element.attributes['out']
      self.inn               = convert_out_to_inn(element.attributes['out'])
      self.er                = element.attributes['er']
      self.r                  = element.attributes['r']
      self.h                 = element.attributes['h']
      self.so                = element.attributes['so']
      self.hr                = element.attributes['hr']
      self.bb               = element.attributes['bb']
      self.w                = element.attributes['w']
      self.l                  = element.attributes['l']
      self.era              = element.attributes['era']
      self.note            = element.attributes['note']
      if count == 1
        self.start = true
      else
        self.start = false
      end
    end
    
   
  # Returns true if this appearance is a start
  def start?
    start
  end
  
  
  # Returns true if this was a quality start
  # A quality start is defined as being greater than or equal to 6 innings and allowing 3 runs or less
  def quality_start?
    if inn.to_i >= 6 && self.r.to_i < 4
      return true
    end
    return false
  end
    
    
  private
  def convert_out_to_inn(outs)
    num_out = outs.to_i
    part = num_out % 3
    return (num_out/3).to_s + '.' + part.to_s
  end
  
end