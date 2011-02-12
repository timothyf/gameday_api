$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'team'

def check_null(value)
  return value unless value==nil
  ' '
end

puts 'Creating team object...'
team = Gameday::Team.new('det')
puts 'Finding game objects...'
games = team.games_for_date('2009', '09', '15')
puts 'Reading pitchers...'
pitchers = games[0].get_pitching

visitors = pitchers[0]
home = pitchers[1]

puts 'Visitors'
visitors.each do |pitcher|
  puts pitcher.pitcher_name + ' ' + check_null(pitcher.note)
end
puts
puts
puts 'Home'
home.each do |pitcher|
  puts pitcher.pitcher_name + ' ' + check_null(pitcher.note)
end

