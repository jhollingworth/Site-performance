require 'yaml'
require 'fileutils'
require 'csv'
require "ftools"
require File.dirname(__FILE__) + '/log'
require File.dirname(__FILE__) + '/ab_output_parser'
require File.dirname(__FILE__) + '/executor'

class SitePerformanceTester
  def initialize(executor = Executor.new, dir = File.dirname(__FILE__))
    @executor = executor
    @dir = dir
  end

  def run(times, base_url)
	Log.message("Base url #{base_url}")
	Log.message("Urls going to be hit #{times} times")
	
	@base_url = base_url
    results = []
    ab_path = File.dirname(__FILE__) + '/../tools/ab.exe'


    File.read(@dir + '/urls.txt').split(/\n/).each do |url|
      full_url = @base_url + url
      output = AbOutputParser.new(@executor.execute("#{ab_path} -n #{times} -c 5 #{full_url}"))
      Log.stat("#{url} - mean concurrent/request (ms)", output.mean_concurrent_time_per_request)
      Log.stat("#{url} - mean/request (ms)", output.mean_time_per_request)
      results << [full_url, output.mean_time_per_request, output.mean_concurrent_time_per_request]
    end
    write_to_output(results)
    results
  end

  private

  def write_to_output(results)
	time_stamp = Time.now.strftime("%Y%m%d.%H%M%S")
	url = @base_url.gsub(/http:\/\//, '').chop
	path = @dir + "/../results/#{url}/#{time_stamp}/"
	FileUtils.mkdir_p(path)
    out = File.open(path + "/#{url}.result.#{time_stamp}.csv",  'w')
     CSV::Writer.generate(out) do |csv|
      csv << ["url","mean time per request (ms)", "mean concurrent time per request (ms)"]
      results.each do |result|
        csv << result
      end
    end
    out.close
  end
end