$: << File.expand_path(File.dirname(__FILE__) + "/../../lib")

require 'test/unit'
require 'pitcher'

class TestPitcher < Test::Unit::TestCase
  
  
  def test_load_from_id
    pitcher = Pitcher.new
    pitcher.load_from_id('2010_04_13_kcamlb_detmlb_1','453286')
    assert pitcher.team_abbrev == 'det'
    assert pitcher.first_name == 'Max'
    assert pitcher.last_name == 'Scherzer'
    assert pitcher.opponent_season.avg == '.256'
    assert pitcher.opponent_career.avg == '.249'
  end
  
  
  def test_get_vs_ab
    pitcher = Pitcher.new
    pitcher.load_from_id('2010_04_13_kcamlb_detmlb_1','425883')
    ab = pitcher.get_vs_ab
    assert ab.length == 27
    
    pitcher = Pitcher.new
    pitcher.load_from_id('2010_04_13_kcamlb_detmlb_1','407878')
    ab = pitcher.get_vs_ab
    assert ab.length == 3
    
    pitcher = Pitcher.new
    pitcher.load_from_id('2010_04_13_kcamlb_detmlb_1','150144')
    ab = pitcher.get_vs_ab
    assert ab.length == 0
  end
  
  
  def test_get_pitches
    pitcher = Pitcher.new
    pitcher.load_from_id('2010_04_13_kcamlb_detmlb_1','425883')
    pitches = pitcher.get_pitches
    assert pitches.length == 104
    
    pitcher = Pitcher.new
    pitcher.load_from_id('2010_04_13_kcamlb_detmlb_1','407878')
    pitches = pitcher.get_pitches
    assert pitches.length == 12
    
    pitcher = Pitcher.new
    pitcher.load_from_id('2010_04_13_kcamlb_detmlb_1','150144')
    pitches = pitcher.get_pitches
    assert pitches.length == 0
  end
  
  
  def test_get_all_ids_for_game
    ids = Pitcher.get_all_ids_for_game('2009_09_20_detmlb_minmlb_1')
    assert_not_nil ids
    assert ids.length == 41
    assert ids[0] == "118158"
    assert ids[1] == "132220"
    assert ids[39] == "545363"
    assert ids[40] == "547820"
  end

end