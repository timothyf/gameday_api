$: << File.expand_path(File.dirname(__FILE__) + "/../../lib")

require 'test/unit'
require 'team'

class TestTeam < Test::Unit::TestCase
  
  
  def setup
    @team = Team.new('det')
  end
  
  
  def test_intialize
    assert @team.city == 'Detroit'
    assert @team.name == 'Tigers'
    assert @team.league == 'American'
  end
  
  
  def test_initialize_not_existing_team
    team = Team.new('abc')
    assert team.city == 'abc'
    assert team.name == 'abc'
    assert team.league == ''
  end
  
  
  def test_initialize_with_no_team
    team = Team.new(nil)
    assert team.city == ''
    assert team.name == ''
    assert team.league == ''
  end
  
  
  def test_teams
    teams = Team.teams
    assert_not_nil teams
    assert teams.length == 33
    assert teams.class == Hash
    assert teams["ana"] == ['Anaheim','Angels','American']
    assert teams["was"] == ['Washington','Nationals','National']
  end
  
  
  def test_get_teams_for_gid
    gid = '2008_04_07_atlmlb_colmlb_1'
    teams = Team.get_teams_for_gid(gid)
    assert teams.length == 2
    assert teams[0].name == 'Braves'
    assert teams[1].name == 'Rockies'
  end
  
  
  def test_games_for_date
    games = @team.games_for_date('2009', '09', '20')
    assert games.length == 1
    game = games[0]
    assert game.home_team_abbrev == 'min'
    assert game.visit_team_abbrev == 'det'
    
    games = @team.games_for_date('2009', '9', '20')
    assert games.length == 1
    game = games[0]
    assert game.home_team_abbrev == 'min'
    assert game.visit_team_abbrev == 'det'
  end
  
  
  def test_get_opening_day_game
    game = @team.get_opening_day_game('2009')
    assert_not_nil game
  end


  def test_opening_day_roster
    roster = @team.opening_day_roster('2009')
    assert_not_nil roster
  end
  
end