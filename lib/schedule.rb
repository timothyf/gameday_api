require 'schedule_game'


module Gameday
  # This class is used to retrieve season schedule information and to query
  # for information related to the schedule.
  class Schedule
  
    attr_accessor :games
  
  
    # Loads a single season schedule from a schedule text file
    def initialize(year)
      @games = []
      read_file(get_sked_filename(year))
    end
  
  
    # Returns the date of opening day as a string with the format YYYYMMDD
    def get_opening_day
      games[0].date
    end
  
  
    # Returns an integer representing the number of games in the season specified
    def get_season_length
      games[games.size-1].home_game_number.to_i
    end
  
  

    def get_sked_filename(year)
      #'schedules/' + year.to_s + 'SKED.TXT'
      File.expand_path(File.dirname(__FILE__) + '/schedules/' + year.to_s + 'SKED.TXT')
    end
  
  
    # Reads the data from a schedule file
    # Each line in the schedule file represents a single game.
    # here is a sample of what a single line in the file looks like:
    #    "20090405","0","Sun","ATL","NL",1,"PHI","NL",1,"n","",""
    #  this is interpreted as:
    #     date, 0, day, visiting team, visiting league, visiting game number, home team, home league, home game number, day or night (d or n), "", ""
    def read_file(filename)
      contents = ''
      File.open(filename, "r") do |infile|
        while (line = infile.gets)
          @games << ScheduleGame.new(line)
        end
      end
    end

  end
end