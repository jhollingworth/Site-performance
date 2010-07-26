require 'rubygems'
require "spec"
require 'mocha'
require File.dirname(__FILE__) + '/../lib/site_performance_tester'

describe "When I run the test" do

  before(:all) do
    @executor = mock('Executor')
    @url = lambda { |sub_domain| "http://foo.com/#{sub_domain}" }
    command = lambda { |sub_domain| "../tools/ab.exe -n 2 -c 5 #{@url.call(sub_domain)}" }
    output = lambda { |time| "Time per request:       #{time} [ms] (mean)\nTime per request:       #{time} [ms] (mean, across all concurrent requests)" }

    @executor.expects(:execute).with(command.call('a')).returns(output.call(1))
    @executor.expects(:execute).with(command.call('b')).returns(output.call(2))
    @tester = SitePerformanceTester.new(@executor, File.dirname(__FILE__))
    @results = @tester.run 2, "http://foo.com/"
  end

  it "should get times back for each url" do
   @results.length.should == 2
   @results[0].should == [@url.call('a'), "1", "1"]
   @results[1].should == [@url.call('b'), "2", "2"]
 end
end