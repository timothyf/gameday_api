$: << File.expand_path(File.dirname(__FILE__) + "/../../lib")

require 'test/unit'
require 'team'

class TestTeam < Test::Unit::TestCase
  
  
  def setup
    @team = Gameday::Team.new('det')
  end
  
  
  def test_intialize
    assert_equal 'Detroit', @team.city
    assert_equal 'Tigers', @team.name
    assert_equal 'American', @team.league
  end
  
  
  def test_initialize_not_existing_team
    team = Gameday::Team.new('abc')
    assert_equal 'abc', team.city
    assert_equal 'abc', team.name
    assert_equal '', team.league
  end
  
  
  def test_initialize_with_no_team
    team = Gameday::Team.new(nil)
    assert_equal '', team.city
    assert_equal '', team.name
    assert_equal '', team.league
  end
  
  
  def test_teams
    teams = Gameday::Team.teams
    assert_not_nil teams
    assert_equal 33, teams.length
    assert_equal Hash, teams.class
    assert_equal ['Anaheim','Angels','American'], teams["ana"]
    assert_equal ['Washington','Nationals','National'], teams["was"]
  end
  
  
  def test_get_teams_for_gid
    gid = '2008_04_07_atlmlb_colmlb_1'
    teams = Gameday::Team.get_teams_for_gid(gid)
    assert_equal 2, teams.length
    assert_equal 'Braves', teams[0].name
    assert_equal 'Rockies', teams[1].name
  end
  
  
  def test_games_for_date
    games = @team.games_for_date('2009', '09', '20')
    assert_equal 1, games.length
    game = games[0]
    assert_equal 'min', game.home_team_abbrev
    assert_equal 'det', game.visit_team_abbrev
    
    games = @team.games_for_date('2009', '9', '20')
    assert_equal 1, games.length
    game = games[0]
    assert_equal 'min', game.home_team_abbrev
    assert_equal 'det', game.visit_team_abbrev
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