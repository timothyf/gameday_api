$: << File.expand_path(File.dirname(__FILE__) + "/../../../lib")

require 'test/unit'
require 'pitcher'

class TestPitcher < Test::Unit::TestCase
  
  
  def setup
    if !@pitcher
      @pitcher = Pitcher.new
      @pitcher.load_from_id('2009_09_20_detmlb_minmlb_1', '434378')
      assert @pitcher.first_name == 'Justin'
      assert @pitcher.last_name == 'Verlander'
    end
  end
  
  
end