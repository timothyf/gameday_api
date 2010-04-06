$: << File.expand_path(File.dirname(__FILE__) + "/../../../lib")

require 'test/unit'
require 'team'

class TestTeam < Test::Unit::TestCase
  
  
  def setup
    if !@team
      @team = Team.new('det')
    end
  end
  
  
  def test_long_running
    all_games_test
    all_home_games_test
    all_away_games_test
    get_leadoff_hitters_by_year_test
    get_leadoff_hitters_unique_test
    get_cleanup_hitters_by_year_test
    get_cleanup_hitters_unique_test
    get_start_pitcher_appearances_by_year_test
    get_starters_unique_test
    get_close_pitcher_appearances_by_year_test
    get_closers_unique_test
    quality_starts_count_test
  end
  
  
  def all_games_test
    games = @team.all_games(2009)
    assert games.length == 163 # Tigers played an extra game in 2009 because of tie
  end
  
  
  def all_home_games_test
    games = @team.all_home_games(2009)
    assert games.length == 81 # Tigers played an extra game in 2009 because of tie
  end
  
  
  def all_away_games_test
    games = @team.all_away_games(2009)
    assert games.length == 82 # Tigers played an extra game in 2009 because of tie
  end
  
  
  def get_leadoff_hitters_by_year_test
    hitters = @team.get_leadoff_hitters_by_year('2009')
    assert hitters.length == 163
  end
  
  
  def get_leadoff_hitters_unique_test
    hitters = @team.get_leadoff_hitters_unique('2009')
    assert hitters.length == 7
  end
  
  
  def get_cleanup_hitters_by_year_test
    hitters = @team.get_cleanup_hitters_by_year('2009')
    assert hitters.length == 163
  end
  
  
  def get_cleanup_hitters_unique_test
    hitters = @team.get_cleanup_hitters_unique('2009')
    assert hitters.length == 6
  end
  
  
  def get_start_pitcher_appearances_by_year_test
    pitchers = @team.get_start_pitcher_appearances_by_year('2009')
    assert pitchers.length == 163
  end
  
  
  def get_starters_unique_test
    pitchers = @team.get_starters_unique('2009')
    assert pitchers.length == 12
  end
  
  
  def get_close_pitcher_appearances_by_year_test
    pitchers = @team.get_close_pitcher_appearances_by_year('2009')
    assert pitchers.length == 163
  end
  
  
  def get_closers_unique_test
    pitchers = @team.get_closers_unique('2009')
    assert pitchers.length == 18
  end
  
  
  def quality_starts_count_test
    count = @team.quality_starts_count('2009')
    puts 'Count = ' + count
    assert count == 63
  end
  
end