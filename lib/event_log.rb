require 'event'
require 'gameday_fetcher'


# Parses the MLB Gameday eventLog.xml file
class EventLog
  
  attr_accessor :home_team, :away_team, :gid
  attr_accessor :home_events, :away_events
  attr_accessor :max_inning
  
  
  # Loads the eventLog XML from the MLB gameday server and parses it using REXML
  def load_from_id(gid)
    @gid = gid
    @xml_data = GamedayFetcher.fetch_eventlog(gid)
    @xml_doc = REXML::Document.new(@xml_data)
    if @xml_doc.root
      set_teams
      set_events
    end
  end
  
  
  # Sets the team names for the teams involved in this game
  def set_teams
  	@xml_doc.elements.each("game/team[@home_team='false']") do |element| 
  		@away_team = element.attributes["name"]
  	end
  	@xml_doc.elements.each("game/team[@home_team='true']") do |element| 
  		@home_team = element.attributes["name"]
  	end
  end
  
  
  def set_events
    @home_events, @away_events = [], []
    @max_inning = 0
    # set away team events
    @xml_doc.elements.each("game/team[@home_team='false']/event") { |element| 
      event = Event.new
      event.load(element, 'away')
      @max_inning = event.inning.to_i unless event.inning.to_i < @max_inning
      @away_events.push event
    }
    # set home team events
    @xml_doc.elements.each("game/team[@home_team='true']/event") { |element| 
      event = Event.new
      event.load(element, 'home')
      @home_events.push event
    }
  end
  
  
  def events_by_inning(inning)
  	events = []
  	@away_events.each do |event|
  		if event.inning == inning
  		  events << event
  		end
  	end
  	@home_events.each do |event|
  		if event.inning == inning
  		  events << event
  		end
  	end
  	events
  end
  
  
  def dump
  	(1..@max_inning).each do |inning|
  		dump_inning(inning.to_s)
  	end
  end
  
  
  def dump_inning(inning)
  	puts 'Inning - ' + inning.to_s
  	events = events_by_inning(inning)
  	events.each do |event|
  		puts event.description
  	end
  end
  
  
  # NOT IMPLEMENTED YET
  def dump_to_file
    GamedayUtil.save_file("eventlog.html", self.to_html('eventlog.html.erb'))
  end
  
  
  # NOT IMPLEMENTED YET
  # Converts the eventlog into a formatted HTML representation.
  # Relies on the eventlog.html.erb template for describing the layout
  def to_html(template_filename)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    template = ERB.new File.new(File.expand_path(File.dirname(__FILE__) + "/" + template_filename)).read, nil, "%"  
    return template.result(binding)
  end
  
  
end