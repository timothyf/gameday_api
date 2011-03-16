require 'gameday_fetcher'
require 'media_highlight'
require 'media_mobile'


class Media
  
  attr_accessor :gid, :highlights, :mobile
  
  
  def load_from_id(gid)
    @gid = gid
    @highlights = []
    @mobile = []
    begin
      @xml_highlights = GamedayFetcher.fetch_media_highlights(gid)
      @xml_doc = REXML::Document.new(@xml_highlights)
      if @xml_doc.root
        @xml_doc.elements.each("highlights/media") do |element| 
          highlight = MediaHighlight.new(element)
          @highlights << highlight
        end
      end
    
      @xml_mobile = GamedayFetcher.fetch_media_mobile(gid)
      @xml_doc = REXML::Document.new(@xml_mobile)
      if @xml_doc.root
        @xml_doc.elements.each("mobile/media") do |element| 
          mobile = MediaMobile.new(element)
          @mobile << mobile
        end
      end
    rescue
      puts "Could not find media for #{gid}"
    end
  end
  
  
end