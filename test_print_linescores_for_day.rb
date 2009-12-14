require 'gameday'

api = Gameday.new
games = api.get_all_games_for_date('2009','09','15')

games.each do |game| 
  puts game.print_linescore
  puts
end