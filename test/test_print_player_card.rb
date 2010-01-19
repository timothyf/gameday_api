# This test prints information and statistics for a player in a format similar
# to what you would see on the back of a baseball card
# Only the past 3 seasons of statistics are included.

# Display card data for Curtis Granderson

$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'team'

team = Team.new('det')

#(2007..2009).each do |year|
  roster = team.opening_day_roster(2009)
  player = roster.find_player_by_last_name('Granderson')
  puts player.first + ' ' + player.last
#end


