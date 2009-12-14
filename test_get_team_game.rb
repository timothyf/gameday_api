require 'team'

team = Team.new('det')
game = team.game_for_date('2009', '09', '15')
puts game.print_linescore