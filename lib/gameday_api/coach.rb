# This class represents a single MLB coach
module GamedayApi
  class Coach
  
    attr_accessor :position, :first, :last, :id, :num
  
  
    def init(element)
        self.id = element.attributes['id']
        self.first = element.attributes['first']
        self.last = element.attributes['last']
        self.num= element.attributes['num']
        self.position = element.attributes['position']
    end
  
  end
end

