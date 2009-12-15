
class BattingAppearance
  
  attr_accessor :id, :batter_name, :pos, :ab, :r, :bb, :sf, :h, :e, :d, :t, :hbp, :so, :hr, :rbi, :sb, :avg

  def init(element)
      self.id = element.attributes['id']
      self.batter_name = element.attributes['name']
      self.pos = element.attributes['pos']
      self.ab = element.attributes['ab']
      self.r = element.attributes['r']
      self.bb = element.attributes['bb']
      self.sf = element.attributes['sf']
      self.h = element.attributes['h']
      self.e = element.attributes['e']
      self.d = element.attributes['d']
      self.t = element.attributes['t']
      self.hbp = element.attributes['hbp']
      self.so = element.attributes['so']
      self.hr = element.attributes['hr']
      self.rbi = element.attributes['rbi']
      self.sb = element.attributes['sb']
      self.avg = element.attributes['avg']  # season avg
  end
  
end