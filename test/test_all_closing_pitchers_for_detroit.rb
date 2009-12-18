# This test will print a list of the starting pitchers for each of the Detroit
# Tigers games from the 2009 season.


$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'team'

team = Team.new('det')
pitchers = team.get_close_pitcher_appearances_by_year('2009')
count = 1
pitchers.each do |appearance|
  puts count.to_s + ' ' + appearance.pitcher_name
  count = count + 1
end
