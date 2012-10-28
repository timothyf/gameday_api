require 'gameday_api/player'

module GamedayApi
  # This class represents a batting record for a single player for a single game
  # Note that this does NOT represent a single atbat of a player, but rather an appearance is a player's stats over an entire game.
  class BattingAppearance
  
    attr_accessor :pid, :batter_name, :pos, :bo, :ab, :po, :r, :bb, :a, :t, :sf, :h, :e, :d
    attr_accessor :hbp, :so, :hr, :rbi, :lob, :sb, :avg, :fldg, :s_rbi, :s_hr
    attr_accessor :player, :atbats

    # Used to initialize from box score data
    def init(element)
        self.pid = element.attributes['id']
        self.batter_name = element.attributes['name']
        self.pos = element.attributes['pos']
        self.bo = element.attributes['bo']
        self.ab = element.attributes['ab']
        self.po = element.attributes['po']
        self.r = element.attributes['r']
        self.bb = element.attributes['bb']
        self.a = element.attributes['a']
        self.t = element.attributes['t']
        self.sf = element.attributes['sf']
        self.h = element.attributes['h']
        self.e = element.attributes['e']
        self.d = element.attributes['d']
        self.hbp = element.attributes['hbp']
        self.so = element.attributes['so']
        self.hr = element.attributes['hr']
        self.rbi = element.attributes['rbi']
        self.lob = element.attributes['lob']
        self.sb = element.attributes['sb']
        self.avg = element.attributes['avg']  # season avg
        self.fldg = element.attributes['fldg']
        self.s_hr = element.attributes['s_hr']
        self.s_rbi = element.attributes['s_rbi']
      end
    
    
    # Looks up the player record using the players.xml file for the player in this appearance
    def get_player
      if !self.player
        # retrieve player object
        player = Player.new
        player.init()
        self.player = player
      end
      self.player
    end
  
  
    # get the atbats associated with this appearance
    def get_atbats
    
    end
  
  end
end
