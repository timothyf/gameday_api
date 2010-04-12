require 'player'

# This class represents a single pitcher whom appeared in an MLB game
class Pitcher < Player
  
  
  # Returns an array of pitcher ids for the game specified
  # pitchers are found by looking in the gid/pitchers directory on gameday
  def self.get_all_ids_for_game(gid)
    pitchers_page = GamedayFetcher.fetch_pitchers_page(gid)
    results = []
    if pitchers_page
      doc = Hpricot(pitchers_page)
      a = doc.at('ul')  
      if a
        (a/"a").each do |link|
          # look at each link inside of a ul tag
          if link.inner_html.include?(".xml") == true
            # if the link contains the text '.xml' then it is a pitcher
            str = link.inner_html
            str.strip!
            pid = str[0..str.length-5]
            results << pid
          end
        end
      end
    end
    results
  end
  
  
end