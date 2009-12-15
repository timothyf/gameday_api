$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'game'

games = Game.find_by_date('2009','09','15')

games.each do |game| 
  puts game.print_linescore
  puts
end