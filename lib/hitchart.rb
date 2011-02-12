require 'hip'

module Gameday
  class Hitchart
  
    attr_accessor :hips, :gid
  
  
    def initialize
      @hips = []
    end
  
  
    def load_from_gid(gid)
      @gid = gid
      @xml_data = GamedayFetcher.fetch_inning_hit(gid)
      @xml_doc = REXML::Document.new(@xml_data)
      if @xml_doc.root
        @xml_doc.elements.each("hitchart/hip") do |element| 
          hip = Hip.new(element)
          @hips << hip
        end
      end
    end
  
  
  end
end