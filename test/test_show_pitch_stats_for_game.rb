# In this test we will print out detailed pitch statistics for
# each of the pitchers who appeared in the specified game between
# Detroit and Kansas City

$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'game'

def print_stats(pa)
  puts pa.pitcher_name
  pc = pa.pitch_count
  puts "   pitches: " + pc.to_s
  pitches = pa.set_pitch_stats
  puts "   balls: " + pa.b.to_s + ', ' + ((pa.b.to_f/pc.to_f)*100).to_i.to_s + '%'
  puts "   strikes: " + pa.s.to_s + ', ' + ((pa.s.to_f/pc.to_f)*100).to_i.to_s + '%'
  puts "   in-play: " + pa.x.to_s + ', ' + ((pa.x.to_f/pc.to_f)*100).to_i.to_s + '%'
  puts "   max speed: " + pa.max_speed.to_s
  puts "   min speed: " + pa.min_speed.to_s
end

game = Game.new('2010_04_12_kcamlb_detmlb_1')
pitchers = game.get_pitching

puts 'Visitors:'
pitchers[0].each do |pa|
  print_stats(pa)
end
puts 
puts
puts 'Home:'
pitchers[1].each do |pa|
  print_stats(pa)
end




