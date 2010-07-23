require 'uri'
require 'time'
require 'net/http'


class Downloader
  def download_time_for(url)
    start = Time.now
    Net::HTTP.get_print(URI.parse(url))
    (Time.now - start)
  end
end