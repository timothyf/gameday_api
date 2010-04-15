require 'player'

# This class represents a single batter whom appeared in an MLB game
class Batter < Player
    
  # attributes read from the batters/(pid).xml file
  attr_accessor :team_abbrev, :pid, :pos, :first_name, :last_name, :jersey_number
  attr_accessor :height, :weight, :bats, :throws, :dob
  attr_accessor :season_stats, :career_stats, :month_stats, :empty_stats
  attr_accessor :men_on_stats, :risp_stats, :loaded_stats, :vs_lhp_stats, :vs_rhp_stats
  
  
  def load_from_id(gid, pid)
    @gid = gid
    @pid = pid
    @xml_data = GamedayFetcher.fetch_batter(gid, pid)
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
    set_batting_stats
  end
  
  
  # Returns an array of all the appearances (Batting) made by this player
  # for the season specified, in which the player had more than 1 hit.
  def get_multihit_appearances(year)
    appearances = get_all_appearances(year)
    mh_appearances = []
    # now go through all appearances to find those for this player
    appearances.each do |appearance|
      if appearance.h.to_i > 1 #add only multihit games
       mh_appearances << appearance
      end
    end
    mh_appearances
  end
  
  
  # Returns an array of batter ids for the game specified
  # batters are found by looking in the gid/batters directory on gameday
  def self.get_all_ids_for_game(gid)
    batters_page = GamedayFetcher.fetch_batters_page(gid)
    results = []
    if batters_page
      doc = Hpricot(batters_page)
      a = doc.at('ul')  
      if a
        (a/"a").each do |link|
          # look at each link inside of a ul tag
          if link.inner_html.include?(".xml") == true
            # if the link contains the text '.xml' then it is a batter
            str = link.inner_html
            str.strip!
            batter_id = str[0..str.length-5]
            results << batter_id
          end
        end
      end
    end
    results
  end
  
  
  private
  
  def set_batting_stats
    @season_stats = BattingStats.new(@xml_doc.root.elements["season"])
    @career_stats = BattingStats.new(@xml_doc.root.elements["career"])
    @month_stats = BattingStats.new(@xml_doc.root.elements["month"])
    @empty_stats = BattingStats.new(@xml_doc.root.elements["Empty"])
    @men_on_stats = BattingStats.new(@xml_doc.root.elements["Men_On"])
    @risp_stats = BattingStats.new(@xml_doc.root.elements["RISP"])
    @loaded_stats = BattingStats.new(@xml_doc.root.elements["Loaded"])
    @vs_lhp_stats = BattingStats.new(@xml_doc.root.elements["vs_LHP"])
    @vs_rhp_stats = BattingStats.new(@xml_doc.root.elements["vs_RHP"])
  end
  
end


class BattingStats
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