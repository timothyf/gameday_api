$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'team'

team = Gameday::Team.new('det')
games = team.games_for_date('2009', '09', '15')
games[0].get_boxscore.dump_to_file



