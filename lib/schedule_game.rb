
# This class represents a single game from a game schedule
# This class is used in conjunction with the Schedule class.
# This is not the class you would use to retrieve game statistics.
class ScheduleGame
  
  attr_accessor :date, :day_of_week, :away_team_abbrev, :away_league, :away_game_number
  attr_accessor :home_team_abbrev, :home_league, :home_game_number, :day_or_night
  
  
  def initialize(line)
    temp = line.split(',')
    @date = temp[0].tr_s('"', '').strip
    @day_of_week = temp[2].tr_s('"', '').strip
    @away_team_abbrev = temp[3].tr_s('"', '').strip
    @away_league = temp[4].tr_s('"', '').strip
    @away_game_number = temp[5].tr_s('"', '').strip
    @home_team_abbrev = temp[6].tr_s('"', '').strip
    @home_league = temp[7].tr_s('"', '').strip
    @home_game_number = temp[8].tr_s('"', '').strip
    @day_or_night = temp[9].tr_s('"', '').strip
  end
  
end