
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
    
  end
  
  
  def download_batters_for_game(gid)
    
  end
  
  
  def download_inning_for_game(gid)
    
  end
  
  
  def download_media_for_game(gid)
    
  end
  
  
  def download_pbp_for_game(gid)
    
  end
  
  
  def download_pitchers_for_game(gid)
    
  end
  
  
  # Downloads the top-level xml directories for the game specified by the passed in game id.
  # The files include:
  #    bench.xml
  #    benchO.xml
  #    boxscore.xml
  #    emailSource.xml
  #    eventLog.xml
  #    game.xml
  #    gamecenter.xml
  #    gameday_Syn.xml
  #    linescore.xml
  #    miniscoreboard.xml
  #    players.xml
  #    plays.xml
  #    preview_atl.xml
  #    preview_col.xml
  #    seriesglance_mlb.xml
  #    wrapupxml.xml
  def download_xml_for_game(gid)
    gid_path = "#{FILE_BASE_PATH}/mlb/year_" + year + "/month_" + month + "/day_" + day + "/gid_"+gid
    write_file("#{gid_path}/bench.xml", GamedayFetcher.fetch_bench(gid))    
    write_file("#{gid_path}/benchO.xml", GamedayFetcher.fetch_bencho(gid))
    write_file("#{gid_path}/boxscore.xml", GamedayFetcher.fetch_boxscore(gid))
    write_file("#{gid_path}/emailSource.xml", GamedayFetcher.fetch_emailsource(gid))
    write_file("#{gid_path}/eventLog.xml", GamedayFetcher.fetch_eventlog(gid))
    write_file("#{gid_path}/game.xml", GamedayFetcher.fetch_game_xml(gid))
    write_file("#{gid_path}/gamecenter.xml", GamedayFetcher.fetch_gamecenter_xml(gid))
    write_file("#{gid_path}/gameday_Syn.xml", GamedayFetcher.fetch_gamedaysyn(gid))
    write_file("#{gid_path}/linescore.xml", GamedayFetcher.fetch_linescore(gid))
    write_file("#{gid_path}/miniscoreboard.xml", GamedayFetcher.fetch_miniscoreboard(gid))
    write_file("#{gid_path}/players.xml", GamedayFetcher.fetch_players(gid))
    write_file("#{gid_path}/plays.xml", GamedayFetcher.fetch_plays(gid))
    write_file("#{gid_path}/preview_home.xml", GamedayFetcher.fetch_preview_home(gid))
    write_file("#{gid_path}/preview_visitor.xml", GamedayFetcher.fetch_preview_visitor(gid))
    write_file("#{gid_path}/seriesglance_mlb.xml", GamedayFetcher.fetch_seriesglance(gid))
    write_file("#{gid_path}/wrapupxml.xml", GamedayFetcher.fetch_wrapup(gid))
  end
  
  
  
  def download_all_for_date(year, month, day)
    
  end
  
  
  def download_batters_for_date(year, month, day)
    
  end
  
  
  def download_pitchers_for_date(year, month, day)
    
  end
  
  
  # Writes the gameday data to the file specified.  
  # Does not overwrite existing files.
  def write_file(file_path, gd_data)
    if !File.exists? file_path
      File.open(file_path, "w") do |data|
        data << gd_data
      end
    end
  end
  
end