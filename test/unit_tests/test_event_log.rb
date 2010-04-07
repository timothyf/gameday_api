$: << File.expand_path(File.dirname(__FILE__) + "/../../lib")

require 'test/unit'
require 'event_log'

class TestEventLog < Test::Unit::TestCase
  
  
  def test_load_from_id
    log = EventLog.new
    log.load_from_id(get_gid)
    assert_not_nil log.gid
    assert log.gid == get_gid
    assert_not_nil log.away_team
    assert_not_nil log.home_team
    assert log.away_team == 'Detroit'
    assert log.home_team == 'Minnesota'
    assert_not_nil log.away_events
    assert_not_nil log.home_events
    assert_not_nil log.max_inning
    assert log.away_events.length == 51
    assert log.home_events.length == 45
    assert log.away_events[0].number == '12'
    assert log.away_events[0].inning == '1'
    assert log.away_events[0].description == 'Curtis Granderson strikes out swinging.  '
    assert log.away_events[0].team == 'away'
    assert log.home_events[0].number == '42'
    assert log.home_events[0].inning == '1'
    assert log.home_events[0].description == 'Denard Span strikes out swinging.  '
    assert log.home_events[0].team == 'home'
  end
  
  
  def test_events_by_inning
    log = EventLog.new
    log.load_from_id(get_gid)
    events = log.events_by_inning('3')
    assert events.length == 8
    assert events[0].number == '157'
    assert events[0].inning == '3'
    assert events[0].description == 'Gerald Laird grounds out, third baseman Matt Tolbert to first baseman Michael Cuddyer.  '
    assert events[0].team == 'away'
    assert events[7].number == '202'
    assert events[7].inning == '3'
    assert events[7].description == 'Michael Cuddyer flies out to center fielder Curtis Granderson.  '
    assert events[7].team == 'home'
  end
  
  
  private
  
  def get_gid
    '2009_09_20_detmlb_minmlb_1'
  end
end