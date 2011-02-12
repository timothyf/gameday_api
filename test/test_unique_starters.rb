# This test will print a list of the pitchers who have started at least
# one game during the 2009 season.


$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'team'

team = Gameday::Team.new('det')
pitchers = team.get_starters_unique('2009')
count = 1
pitchers.each do |appearance|
  puts count.to_s + ' ' + appearance.pitcher_name
  count = count + 1
end
