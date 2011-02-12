require 'net/http'
require 'md5'

module Gameday
  class CacheFetcher
  
     def initialize(cache_dir=File.expand_path(File.dirname(__FILE__)) + '/tmp')
        # this is the dir where we store our cache
        @cache_dir = cache_dir
     end
   
   
      def fetch(url)
        file = MD5.hexdigest(url)
        file_path = File.join("", @cache_dir, file)
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
          #puts 'Using cache'
        end
        return File.new(file_path)
     end
   
  end
end