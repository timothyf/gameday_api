# In this test we are attempting to print out all of the appearances 
# for Detroit Tiger pitcher Nate Robertson during the 2009 MLB season.
# Nate pitched as both a reliever and a starter during the 2009 season.

$: << File.expand_path(File.dirname(__FILE__) + "/../lib")

require 'pitcher'

nate_r = Gameday::Pitcher.new
nate_r.load_from_id('2009_09_20_detmlb_minmlb_1', '425146')

# lets verify that we found the right player by printing out his name
puts nate_r.first_name + ' ' + nate_r.last_name + ' ' + nate_r.team_abbrev

appearances = nate_r.get_all_appearances('2009')

puts 'Games Pitched = ' + appearances.size.to_s

puts 'Pitch Counts:'
starts = 0
count = 1
appearances.each do |appear|
  if appear.start == true
    starts += 1
  end
  puts 'Game #' + count.to_s + ': ' + appear.pitch_count.to_s
  count += 1
end

puts 'Games Started = ' + starts.to_s

