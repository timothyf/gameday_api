$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'team'

team = Gameday::Team.new('det')
games = team.games_for_date('2009', '09', '15')

players = games[0].get_rosters

puts 'PLAYERS'
count = 1
players[1].players.each do |player|
  puts count.to_s + ' ' + player.first + ' ' + player.last + ' ' + player.position + ' ' + player.dob
  count = count + 1
end

puts ''
puts 'COACHES'
count = 1
players[1].coaches.each do |coach|
  puts count.to_s + ' ' + coach.first + ' ' + coach.last + ' ' + coach.position
  count = count + 1
end
