require 'rubygems'
require "spec"
require 'mocha'
require File.dirname(__FILE__) + '/../lib/site_performance_tester'

describe "When I run the test" do

  before(:all) do
    @downloader = mock('Downloader')
    @downloader.expects(:download_time_for).with('http://foo.com/a').returns(1)
    @downloader.expects(:download_time_for).with('http://foo.com/b').returns(2)
    @downloader.expects(:download_time_for).with('http://foo.com/c').returns(3)
    @downloader.expects(:download_time_for).with('http://foo.com/d').returns(4)
    @tester = SitePerformanceTester.new(@downloader, File.dirname(__FILE__))
    @results = @tester.run
  end

 it "should get times back for each url" do
   @results.length.should == 4
   @results['http://foo.com/a'].should == 1
   @results['http://foo.com/b'].should == 2
   @results['http://foo.com/c'].should == 3
   @results['http://foo.com/d'].should == 4
 end
  
end