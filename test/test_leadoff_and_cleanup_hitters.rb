# This test will print two lists.  The first list will be of the leadoff hitters for each of the Detroit
# Tigers games from the 2009 season.  The second list will be of the cleanup (4th) hitters for each of
# the Tigers 2009 games.


$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'team'

team = Team.new('det')
hitters = team.get_leadoff_hitters_by_year('2009')
count = 1
hitters.each do |appearance|
  puts count.to_s + ' ' + appearance.batter_name
  count = count + 1
end

cleanup = team.get_cleanup_hitters_by_year('2009')
count = 1
cleanup.each do |appearance|
  puts count.to_s + ' ' + appearance.batter_name
  count = count + 1
end
