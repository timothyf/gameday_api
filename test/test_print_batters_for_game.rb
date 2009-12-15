$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'team'

team = Team.new('det')
games = team.games_for_date('2009', '09', '15')

lineups = games[0].get_lineups

visitors = lineups[0]
home = lineups[1]

puts 'Visitors'
visitors.each do |batter|
  puts batter.batter_name
end
puts
puts
puts 'Home'
home.each do |batter|
  puts batter.batter_name
end
