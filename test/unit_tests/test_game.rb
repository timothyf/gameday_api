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
    assert game.gid == '2008_04_07_atlmlb_colmlb_1'
    assert game.home_team_abbrev == 'col'
    assert game.visit_team_abbrev == 'atl'
    assert game.visiting_team.abrev == 'atl'
    assert game.home_team.abrev == 'col'
    assert game.year == '2008'
    assert game.month == '04'
    assert game.day == '07'
    assert game.game_number == '1'
    assert game.home_team_name == 'Colorado'
    assert game.visit_team_name == 'Atlanta'
  end
  
  
  def test_find_by_date
    games = Game.find_by_date('2009', '9', '20')
    assert_not_nil games
    assert games.length == 16
  end
  
  
  def test_find_by_month
    games = Game.find_by_month('2009', '9')
    assert_not_nil games
    assert games.length == 438
  end
  
  
  def test_get_rosters
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    rosters = game.get_rosters
    assert rosters[0].team_name == 'Detroit Tigers'
    assert rosters[1].team_name == 'Minnesota Twins'
    assert rosters[0].players.length == 34
    assert rosters[1].players.length == 31
  end
  
  
  def test_get_eventlog
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    eventlog = game.get_eventlog
    assert_not_nil eventlog
    assert eventlog.home_team == 'Minnesota'
    assert eventlog.away_team == 'Detroit'
  end
  
  
  def test_get_boxscore
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    bs = game.get_boxscore
    assert_not_nil bs
    assert bs.away_fname == 'Detroit Tigers'
    assert bs.home_fname == 'Minnesota Twins'
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
    assert sp.length == 2
    assert sp[0].pitcher_name == 'Robertson, N'
    assert sp[1].pitcher_name == 'Baker, S'
  end
  
  
  def test_get_closing_pitchers
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    cp = game.get_closing_pitchers
    assert cp.length == 2
    assert cp[0].pitcher_name == 'Rodney'
    assert cp[1].pitcher_name == 'Keppel'
  end
  
  
  def test_get_pitchers
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    pitchers = game.get_pitchers('home')
    assert pitchers.length == 6
    pitchers = game.get_pitchers('away')
    assert pitchers.length == 4
  end
  
  
  def test_get_pitches
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    pitches = game.get_pitches('407845')
    assert pitches.length == 16
    assert pitches[0].start_speed = '95.7'
  end
  
  
  def test_get_batters
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    batters = game.get_batters('home')
    assert batters.length == 16
    assert batters[0].batter_name == 'Span'
    batters = game.get_batters('away')
    assert batters.length == 16
    assert batters[0].batter_name == 'Granderson'
  end
  
  
  def test_get_lineups
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    lineups = game.get_lineups
    assert lineups.length == 2
    assert lineups[0].length == 16
    assert lineups[1].length == 16
    assert lineups[0][0].batter_name == 'Granderson'
    assert lineups[1][0].batter_name == 'Span'
  end
  
  
  def test_get_pitching
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    pitching = game.get_pitching
    assert pitching.length == 2
    assert pitching[0].length == 4
    assert pitching[1].length == 6
  end
  
  
  def test_get_winner
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    winner = game.get_winner
    assert winner == 'det'
    game = Game.new('2009_09_20_nyamlb_seamlb_1')
    winner = game.get_winner
    assert winner == 'sea'
  end
  
  
  def test_get_score
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    score = game.get_score
    assert score[0] == '6'
    assert score[1] == '2'
  end
  
  
  def test_get_attendance
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    attend = game.get_attendance
    assert attend == '36,335'
    
    game = Game.new('2010_04_10_bosmlb_kcamlb_1')
    attend = game.get_attendance
    assert attend == '37,505'
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
    assert innings.length == 9
    
    game = Game.new('2009_05_02_kcamlb_minmlb_1')
    innings = game.get_innings
    assert innings.length == 11
  end
  
  
  def test_get_atbats
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    atbats = game.get_atbats
    assert_not_nil atbats
    assert atbats.length == 81
  end
  
  
  def test_get_hitchart
    game = Game.new('2009_09_20_detmlb_minmlb_1')
    hitchart = game.get_hitchart
    assert_not_nil hitchart
    assert hitchart.hips.length == 57
  end
  
  
  def test_get_num_innings
    game = Game.new('2008_04_07_atlmlb_colmlb_1')
    assert game.get_num_innings == 9
    
    game = Game.new('2009_05_02_kcamlb_minmlb_1')
    assert game.get_num_innings == 11
  end
  
  
end