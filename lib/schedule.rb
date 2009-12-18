require 'schedule_game'



# This class is used to retrieve season schedule information
class Schedule
  
  attr_accessor :games
  
  # Loads a single season schedule from a schedule text file
  def self.load(year)
    @games = []
    sked_file = read_file(get_sked_filename(year))
    schedule = Schedule.new
    return schedule
  end
  
  
  private
  def get_sked_filename(year)
    year.to_s + 'SKED.TXT'
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
        games << line
      end
    end
  end

end
