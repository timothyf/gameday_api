require 'game'
require 'batter'
require 'pitcher'



# This class is used to download data files from the MLB Gameday site to
# local storage.  The data that is downloaded will be stored into a path that
# replicates the MLB Gameday paths, for example here is a sample path for
# a specified date:
#   /components/game/mlb/year_2008/month_04/day_07
#
class DataDownloader
  
  FILE_BASE_PATH = 'components/game'
  
  
  def fetch(url)
    file_path = File.join(url)
    # we check if the file -- a MD5 hexdigest of the URL -- exists
    #  in the dir. If it does we just read data from the file and return
    if !File.exists? file_path
      #puts 'Not found in cache'
      # if the file does not exist (or if the data is not fresh), we
      #  make an HTTP request and save it to a file
      #puts 'Fetching file from internet...'
      File.open(file_path, "w") do |data|
         data << Net::HTTP.get_response(URI.parse(url)).body
      end
    else
      # file already exists locally
    end
   end
    
    
  # Downloads all data files associated with the game specified by the game id passed in.
  def download_all_for_game(gid)
    download_xml_for_game(gid)
    download_batters_for_game(gid)
    download_inning_for_game(gid)
    download_media_for_game(gid)
    download_notification_for_game(gid)
    download_onbase_for_game(gid)
    download_pitchers_for_game(gid)
  end
  
  
  def download_batters_for_game(gid)
    batter_path = get_gid_path(gid) + "/batters"
    ids = Batter.get_all_ids_for_game(gid)
    ids.each do |id|
      if !File.exists? "#{batter_path}/#{id}.xml"
        write_file("#{batter_path}/#{id}.xml", GamedayFetcher.fetch_batter(gid, id)) 
      end
    end
  end
  
  
  def download_inning_for_game(gid)
    game = Game.new(gid)
    inn_count = game.get_num_innings
    inn_path = get_gid_path(gid) + "/inning"
    (1..inn_count).each do |inn|
      if !File.exists? "#{inn_path}/inning_#{inn}.xml"
        write_file("#{inn_path}/inning_#{inn}.xml", GamedayFetcher.fetch_inningx(gid, inn)) 
      end  
    end 
    if !File.exists? "#{inn_path}/inning_Scores.xml"
      write_file("#{inn_path}/inning_Scores.xml", GamedayFetcher.fetch_inning_scores(gid))
    end
    if !File.exists? "#{inn_path}/inning_hit.xml"
      write_file("#{inn_path}/inning_hit.xml", GamedayFetcher.fetch_inning_hit(gid)) 
    end
  end
  
  
  def download_media_for_game(gid)
    media_path = get_gid_path(gid) + "/media"
    if !File.exists? "#{media_path}/highlights.xml"
      write_file("#{media_path}/highlights.xml", GamedayFetcher.fetch_media_highlights(gid))  
    end
    if !File.exists? "#{media_path}/mobile.xml"  
      write_file("#{media_path}/mobile.xml", GamedayFetcher.fetch_media_mobile(gid))  
    end  
  end
  
  
  def download_notification_for_game(gid)
    game = Game.new(gid)
    inn_count = game.get_num_innings
    notif_path = get_gid_path(gid) + "/notifications"
    (1..inn_count).each do |inn|
      if !File.exists? "#{notif_path}/notifications_#{inn}.xml" 
        write_file("#{notif_path}/notifications_#{inn}.xml", GamedayFetcher.fetch_notifications_inning(gid, inn)) 
      end
    end   
    if !File.exists? "#{notif_path}/notifications_full.xml"
      write_file("#{notif_path}/notifications_full.xml", GamedayFetcher.fetch_notifications_full(gid))
    end
  end
  
  
  def download_onbase_for_game(gid)
    onbase_path = get_gid_path(gid) + "/onbase"
    write_file("#{onbase_path}/linescore.xml", GamedayFetcher.fetch_onbase_linescore(gid))    
    write_file("#{onbase_path}/plays.xml", GamedayFetcher.fetch_onbase_plays(gid))  
  end
  
  
  def download_pitchers_for_game(gid)
    pitcher_path = get_gid_path(gid) + "/pitchers"
    ids = Pitcher.get_all_ids_for_game(gid)
    ids.each do |id|
      if !File.exists? "#{pitcher_path}/#{id}.xml" 
        write_file("#{pitcher_path}/#{id}.xml", GamedayFetcher.fetch_pitcher(gid, id)) 
      end
    end
  end
  
  
  # Downloads the top-level xml directories for the game specified by the passed in game id.
  # The files include:
  #    bench.xml
  #    benchO.xml
  #    boxscore.xml
  #    emailSource.xml
  #    eventLog.xml
  #    game.xml
  #    game_events.xml
  #    gamecenter.xml
  #    gameday_Syn.xml
  #    linescore.xml
  #    miniscoreboard.xml
  #    players.xml
  #    plays.xml
  def download_xml_for_game(gid)
    gid_path = get_gid_path(gid)
    write_file("#{gid_path}/bench.xml", GamedayFetcher.fetch_bench(gid))    
    write_file("#{gid_path}/benchO.xml", GamedayFetcher.fetch_bencho(gid))
    write_file("#{gid_path}/boxscore.xml", GamedayFetcher.fetch_boxscore(gid))
    write_file("#{gid_path}/emailSource.xml", GamedayFetcher.fetch_emailsource(gid))
    write_file("#{gid_path}/eventLog.xml", GamedayFetcher.fetch_eventlog(gid))
    write_file("#{gid_path}/game.xml", GamedayFetcher.fetch_game_xml(gid))
    write_file("#{gid_path}/game_events.xml", GamedayFetcher.fetch_game_events(gid))
    write_file("#{gid_path}/gamecenter.xml", GamedayFetcher.fetch_gamecenter_xml(gid))
    write_file("#{gid_path}/gameday_Syn.xml", GamedayFetcher.fetch_gamedaysyn(gid))
    write_file("#{gid_path}/linescore.xml", GamedayFetcher.fetch_linescore(gid))
    write_file("#{gid_path}/miniscoreboard.xml", GamedayFetcher.fetch_miniscoreboard(gid))
    write_file("#{gid_path}/players.xml", GamedayFetcher.fetch_players(gid))
    write_file("#{gid_path}/plays.xml", GamedayFetcher.fetch_plays(gid))
  end
  
  
  def download_xml_for_date(year, month, day)
    day_path = get_day_path(year, month, day)
    write_file("#{day_path}/epg.xml", GamedayFetcher.fetch_epg(year, month, day))
    write_file("#{day_path}/master_scoreboard.xml", GamedayFetcher.fetch_scoreboard(year, month, day))
    write_file("#{day_path}/media/highlights.xml", GamedayFetcher.fetch_day_highlights(year, month, day))
  end
  
  
  def download_all_for_date(year, month, day)
    download_xml_for_date(year, month, day)
    games = Game.find_by_date(year, month, day)
    games.each do |game|
      download_all_for_game(game.gid)
    end
  end
  
  
  def download_all_for_month(year, month)   
    start_date = Date.new(year.to_i, month.to_i) # first day of month
    end_date = (start_date >> 1)-1 # last day of month
    ((start_date)..(end_date)).each do |dt| 
      puts dt.day
      download_all_for_date(year, month, dt.day.to_s)
    end
  end
  
  
  private
  
  
  def get_day_path(year, month, day)
    year = GamedayUtil.convert_digit_to_string(year.to_i)
    month = GamedayUtil.convert_digit_to_string(month.to_i)
    day = GamedayUtil.convert_digit_to_string(day.to_i)
    "#{FILE_BASE_PATH}/mlb/year_" + year + "/month_" + month + "/day_" + day  
  end
  
  
  def get_gid_path(gid)
    gameday_info = GamedayUtil.parse_gameday_id('gid_' + gid)
    "#{FILE_BASE_PATH}/mlb/year_" + gameday_info['year'] + "/month_" + gameday_info['month'] + "/day_" + gameday_info['day'] + "/gid_"+gid 
  end
  
  
  # Writes the gameday data to the file specified.  
  # Does not overwrite existing files.
  def write_file(file_path, gd_data)
    if gd_data && !File.exists?(file_path)
      FileUtils.mkdir_p(File.dirname(file_path))
      File.open(file_path, "w") do |data|
        data << gd_data
      end
    end
  end
  
end