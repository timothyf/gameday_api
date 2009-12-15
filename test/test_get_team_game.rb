$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'team'

team = Team.new('det')
games = team.games_for_date('2009', '09', '15')
games.each do |game|
  puts game.print_linescore
end