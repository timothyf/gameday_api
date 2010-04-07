class MediaHighlight
  
  attr_accessor :id, :date, :type, :v
  attr_accessor :headline, :duration, :thumb_url
  attr_accessor :res_400_url, :res_500_url, :res_800_url
  
  def initialize(element)
    @id = element.attributes['id']
    @date = element.attributes['date']
    @type = element.attributes['type']
    @v = element.attributes['v']
    @headline = element.elements["headline"].text
    @duration = element.elements["duration"].text
    @thumb_url = element.elements["thumb"].text
    @res_400_url = element.elements["url[@playback_scenario='FLASH_400K_600X338']"].text
    @res_500_url = element.elements["url[@playback_scenario='FLASH_500K_512X288']"].text
    @res_800_url = element.elements["url[@playback_scenario='FLASH_800K_640X360']"].text
  end
  
  
end