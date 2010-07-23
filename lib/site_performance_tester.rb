require 'yaml'
require 'fileutils'
require 'csv'
require File.dirname(__FILE__) + '/downloader'

class SitePerformanceTester
  def initialize(*args)
    if args.length == 0
      @downloader = Downloader.new
      @dir = File.dirname(__FILE__)
    else
      @downloader = args[0]
      @dir = args[1]
    end 
  end

  def run()
    base_url = YAML.load(File.read(@dir + '/config.yaml'))['base-url']
    results = {}
    File.read(@dir + '/urls.txt').split(/\n/).each do |url|
      url = base_url + url
      results[url] = @downloader.download_time_for(url)      
    end
    write_to_output(results)
    results
  end

  private

  def write_to_output(results)
    out = File.open(@dir + '/result.csv',  'w')
     CSV::Writer.generate(out) do |csv|
      csv << ["url", "download time"]
      results.each do |url, time|
        csv << [url, time]
      end
    end
    out.close
  end
end