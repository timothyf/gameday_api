# This test will print the scoreboard containing linescores for the specified date


$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'scoreboard'

sb = Scoreboard.new
sb.load_for_date('2009', '09', '20')

puts 'Games played = ' + sb.games.length.to_s

sb.games.each do |game|
  away_innings_string = ' '
  game.away_innings.each do |inning|
    away_innings_string += inning
  end
  home_innings_string = ' '
  game.home_innings.each do |inning|
    if inning
      home_innings_string += inning
    end
  end
  # add in totals
  away_innings_string += ' ' + game.away_runs + ' ' +  game.away_hits + ' ' +  game.away_errors
  home_innings_string += ' ' + game.home_runs + ' ' +  game.home_hits + ' ' +  game.home_errors
  
  puts game.away_team_city + away_innings_string
  puts game.home_team_city + home_innings_string
  puts 'Winning Pitcher: ' + game.winning_pitcher.first + ' ' + game.winning_pitcher.last
  puts 'Losing Pitcher: ' + game.losing_pitcher.first + ' ' + game.losing_pitcher.last
  if game.save_pitcher.last && game.save_pitcher.last != ''
    puts 'Save Pitcher: ' + game.save_pitcher.first + ' ' + game.save_pitcher.last
  end
  puts ''
end