require 'gameday_api/player'

module GamedayApi

  # This class represents a single pitcher whom appeared in an MLB game
  class Pitcher < Player
  
    # attributes read from the pitchers/(pid).xml file
    attr_accessor :team_abbrev, :gid, :pid, :first_name, :last_name, :jersey_number
    attr_accessor :height, :weight, :bats, :throws, :dob, :position
    attr_accessor :opponent_season, :opponent_career, :opponent_empty, :opponent_men_on, :opponent_risp
    attr_accessor :opponent_loaded, :opponent_vs_l, :opponent_vs_r
  
    attr_accessor :game
  
  
    # Loads a Pitcher object given a game id and a player id
    def load_from_id(gid, pid)
      @gid = gid
      @pid = pid
      @position = 'P'
      @xml_data = GamedayFetcher.fetch_pitcher(gid, pid)
      @xml_doc = REXML::Document.new(@xml_data)
      @team_abbrev = @xml_doc.root.attributes["team"]
      @first_name = @xml_doc.root.attributes["first_name"]
      @last_name = @xml_doc.root.attributes["last_name"]
      @jersey_number = @xml_doc.root.attributes["jersey_number"]
      @height = @xml_doc.root.attributes["height"]
      @weight = @xml_doc.root.attributes["weight"]
      @bats = @xml_doc.root.attributes["bats"]
      @throws = @xml_doc.root.attributes["throws"]
      @dob = @xml_doc.root.attributes['dob']
      set_opponent_stats
    end
  
  
    # Returns an array of PitchingAppearance objects for all of the pitchers starts
    def get_all_starts(year)
      results = []
      app = get_all_appearances(year)
      if app.start == true
        results << app
      end
    end
  
  
    # Returns an array of the atbats against this pitcher during this game
    def get_vs_ab
      results = []
      abs = get_game.get_atbats
      abs.each do |ab|
        if ab.pitcher_id == @pid
          results << ab
        end
      end
      results
    end
  
  
    # Returns an array of pitches thrown by this pitcher during this game
    def get_pitches
      results = []
      ab = get_vs_ab
      ab.each do |ab|
        results << ab.pitches
      end
      results.flatten
    end
  
  
    def get_game
      if !@game
        @game = Game.new(@gid)
      end
      @game
    end
  
  
    # Returns an array of pitcher ids for the game specified
    # pitchers are found by looking in the gid/pitchers directory on gameday
    def self.get_all_ids_for_game(gid)
      pitchers_page = GamedayFetcher.fetch_pitchers_page(gid)
      results = []
      if pitchers_page
        doc = Hpricot(pitchers_page)
        a = doc.at('ul')  
        if a
          (a/"a").each do |link|
            # look at each link inside of a ul tag
            if link.inner_html.include?(".xml") == true
              # if the link contains the text '.xml' then it is a pitcher
              str = link.inner_html
              str.strip!
              pid = str[0..str.length-5]
              results << pid
            end
          end
        end
      end
      results
    end
  
  
    private
  
    def set_opponent_stats
      @opponent_season = OpponentStats.new(@xml_doc.root.elements["season"])
      @opponent_career = OpponentStats.new(@xml_doc.root.elements["career"])
      @opponent_empty = OpponentStats.new(@xml_doc.root.elements["Empty"])
      @opponent_men_on = OpponentStats.new(@xml_doc.root.elements["Men_On"])
      @opponent_risp = OpponentStats.new(@xml_doc.root.elements["RISP"])
      @opponent_loaded = OpponentStats.new(@xml_doc.root.elements["Loaded"])
      @opponent_vs_l = OpponentStats.new(@xml_doc.root.elements["vs_LHB"])
      @opponent_vs_r = OpponentStats.new(@xml_doc.root.elements["vs_RHB"])
    end
  
  end


  class OpponentStats
    attr_accessor :des, :avg, :ab, :hr, :bb, :so
  
    def initialize(element)
      if element.attributes['des']
        @des = element.attributes['des']
      end
      @avg = element.attributes['avg']
      @ab = element.attributes['ab']
      @hr = element.attributes['hr']
      @bb = element.attributes['bb']
      @so = element.attributes['so']
    end
  end
end