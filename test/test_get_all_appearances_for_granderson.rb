# In this test we are attempting to print out all of the appearances 
# for Curtis Granderson during the 2009 MLB season.

$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'team'

team = Team.new('det')
# get the Detroit Tigers opening day game because we know that Granderson was
# on the Tigers opening day roster.
games = team.games_for_date('2009', '04', '06')
rosters = games[0].get_rosters
# we know the Tigers were the away team, so get the players from the away team roster
detroit_players = rosters[0].players 
# now find the player whose last name matches 'Granderson'
grandy = nil
detroit_players.each do |player|
  if player.last == 'Granderson'
    grandy = player
    break
  end
end

# lets verify that we found the right player by printing out his name
puts grandy.first + ' ' + grandy.last + ' ' + grandy.team

appearances = grandy.get_all_appearances('2009')

puts 'Games Played = ' + appearances.size.to_s
count = 1
ab, h, hr, rbi, sb = 0, 0, 0, 0, 0
appearances.each do |appearance|
  puts "#{count.to_s} AB: #{appearance.ab}"
  count = count + 1
  ab = ab + appearance.ab.to_i
  h = h + appearance.h.to_i
  hr = hr + appearance.hr.to_i
  rbi = rbi + appearance.rbi.to_i
  sb = sb + appearance.sb.to_i
end
avg = ((h.to_f/ab.to_f)*1000).round/1000.0

puts 'AB   H   AVG   HR   RBI   SB'
puts ab.to_s + ' ' + h.to_s  + ' ' + (avg.to_s).sub!(/\A0+/, ' ') + '  '  + hr.to_s + ' ' + rbi.to_s + ' ' + sb.to_s

