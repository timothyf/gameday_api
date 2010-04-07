require 'player'

# This class represents a single batter whom appeared in an MLB game
class Batter < Player
  
  
  # Returns an array of batter ids for the game specified
  # batters are found by looking in the gid/batters directory on gameday
  def self.get_all_ids_for_game(gid)
    batters_page = GamedayFetcher.fetch_batters_page(gid)
    doc = Hpricot(batters_page)
    results = []
    a = doc.at('ul')  
    (a/"a").each do |link|
      # look at each link inside of a ul tag
      if link.inner_html.include?(".xml") == true
        # if the link contains the text '.xml' then it is a batter
        str = link.inner_html
        str.strip!
        batter_id = str[0..str.length-5]
        results << batter_id
      end
    end
    results
  end
  
  
end