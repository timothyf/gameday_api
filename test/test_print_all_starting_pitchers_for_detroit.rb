# This test will print a list of the starting pitchers for each of the Detroit
# Tigers games from the 2009 season.


$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'team'

team = Team.new('det')

games = team.all_games('2009')

games.each do |game|
  starters = game.get_starting_pitchers
  if game.home_team_abbrev == 'det'
    puts 'Home: ' + starters[1]['name']
  else
    puts 'Visitors: ' + starters[0]['name']
  end
end