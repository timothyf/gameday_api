require 'roster'


# This class represents the players.xml file found on the gameday server for each MLB game.
#  The players.xml file contains a listing of all players on the home and away teams for the specified game
class Players
  
  attr_accessor :xml_data, :gid, :venue, :date, :rosters
  
  # Loads the players XML from the MLB gameday server and parses it using REXML
  def load_from_id(gid)
    @gid = gid
    @rosters = []
    @xml_data = GamedayFetcher.fetch_players(gid)
    @xml_doc = REXML::Document.new(@xml_data)
    if @xml_doc.root
      self.set_rosters
    end
  end
  
  
  def set_rosters()
    away_roster = Roster.new
    away_roster.init(@xml_doc.root.elements["team[@type='away']"], self.gid)
    self.rosters << away_roster
    home_roster = Roster.new
    home_roster.init(@xml_doc.root.elements["team[@type='home']"], self.gid)
    self.rosters << home_roster
  end
  
end