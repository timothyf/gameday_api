$: << File.expand_path(File.dirname(__FILE__) + "/../../lib")

require 'test/unit'
require 'game'

class TestGame < Test::Unit::TestCase
  
  
  def setup

  end
  
  
  def test_initialize
    gid = '2008_04_07_atlmlb_colmlb_1'
    game = Game.new(gid)
    assert_not_nil game
    assert_equal '2008_04_07_atlmlb_colmlb_1', game.gid
    assert_equal 'col', game.home_team_abbrev
    assert_equal 'atl', game.visit_team_abbrev
    assert_equal 'atl', game.visiting_team.abrev
    assert_equal 'col', game.home_team.abrev
    assert_equal '2008', game.year
    assert_equal '04', game.month
    assert_equal '07', game.day
    assert_equal '1', game.game_number
    assert_equal 'Colorado', game.home_team_name
    assert_equal 'Atlanta', game.visit_team_name
  end
  
  
  def test_find_by_date
    games = Game.find_by_date('2009', '9', '20')
    assert_not_nil games
    assert_equal 16, games.length
  end
  
  
  def test_find_by_month
    games = Game.find_by_month('2009', '9')
    assert_not_nil games
    assert_equal 438, games.length
  end
  
  
  def test_get_rosters
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    rosters = game.get_rosters
    assert_equal 'Detroit Tigers', rosters[0].team_name
    assert_equal 'Minnesota Twins', rosters[1].team_name
    assert_equal 34, rosters[0].players.length
    assert_equal 31, rosters[1].players.length
  end
  
  
  def test_get_eventlog
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    eventlog = game.get_eventlog
    assert_not_nil eventlog
    assert_equal 'Minnesota', eventlog.home_team
    assert_equal 'Detroit', eventlog.away_team
  end
  
  
  def test_get_boxscore
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    bs = game.get_boxscore
    assert_not_nil bs
    assert_equal 'Detroit Tigers', bs.away_fname
    assert_equal 'Minnesota Twins', bs.home_fname
  end
  
  
  def test_print_linescocre
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    ls = game.print_linescore
    assert_not_nil ls
    assert ls.length > 0
  end
  
  
  def test_get_starting_pitchers
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    sp = game.get_starting_pitchers
    assert_equal 2, sp.length
    assert_equal 'Robertson, N', sp[0].pitcher_name
    assert_equal 'Baker, S', sp[1].pitcher_name
  end
  
  
  def test_get_closing_pitchers
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    cp = game.get_closing_pitchers
    assert_equal 2, cp.length
    assert_equal 'Rodney', cp[0].pitcher_name
    assert_equal 'Keppel', cp[1].pitcher_name
  end
  
  
  def test_get_pitchers
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    pitchers = game.get_pitchers('home')
    assert_equal 6, pitchers.length
    pitchers = game.get_pitchers('away')
    assert_equal 4, pitchers.length
  end
  
  
  def test_get_pitches
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    pitches = game.get_pitches('407845')
    assert_equal 16, pitches.length
    assert pitches[0].start_speed = '95.7'
  end
  
  
  def test_get_batters
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    batters = game.get_batters('home')
    assert_equal 16, batters.length
    assert_equal 'Span', batters[0].batter_name
    batters = game.get_batters('away')
    assert_equal 16, batters.length
    assert_equal 'Granderson', batters[0].batter_name
  end
  
  
  def test_get_lineups
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    lineups = game.get_lineups
    assert_equal 2, lineups.length
    assert_equal 16, lineups[0].length
    assert_equal 16, lineups[1].length
    assert_equal 'Granderson', lineups[0][0].batter_name
    assert_equal 'Span', lineups[1][0].batter_name
  end
  
  
  def test_get_pitching
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    pitching = game.get_pitching
    assert_equal 2, pitching.length
    assert_equal 4, pitching[0].length
    assert_equal 6, pitching[1].length
  end
  
  
  def test_get_winner
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    winner = game.get_winner
    assert_equal 'det', winner
    game = Game.new('2009_09_20_nyamlb_seamlb_1')
    winner = game.get_winner
    assert_equal 'sea', winner
  end
  
  
  def test_get_score
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    score = game.get_score
    assert_equal '6', score[0]
    assert_equal '2', score[1]
  end
  
  
  def test_get_attendance
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    attend = game.get_attendance
    assert_equal '36,335', attend
    
    game = Game.new('2010_04_10_bosmlb_kcamlb_1')
    attend = game.get_attendance
    assert_equal '37,505', attend
  end
  
  
  def test_get_media
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    media = game.get_media
    assert_not_nil media
    assert_not_nil media.highlights
    assert_not_nil media.mobile
  end
  
  
  def test_get_innings
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    innings = game.get_innings
    assert_equal 9, innings.length
    
    game = Game.new('2009_05_02_kcamlb_minmlb_1')
    innings = game.get_innings
    assert_equal 11, innings.length
  end
  
  
  def test_get_atbats
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    atbats = game.get_atbats
    assert_not_nil atbats
    assert_equal 81, atbats.length
  end
  
  
  def test_get_hitchart
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    hitchart = game.get_hitchart
    assert_not_nil hitchart
    assert_equal 57, hitchart.hips.length
  end
  
  
  def test_get_num_innings
    game = Game.new('2008_04_07_atlmlb_colmlb_1')
    assert_equal 9, game.get_num_innings
    
    game = Game.new('2009_05_02_kcamlb_minmlb_1')
    assert_equal 11, game.get_num_innings
  end
  
  
end