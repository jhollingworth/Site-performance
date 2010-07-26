require 'rubygems'
require "spec"
require 'mocha'
require 'fileutils'
require File.dirname(__FILE__) + '/../lib/ab_output_parser'

describe "When I parse the output from ab" do

	before(:all) do
		@parser = AbOutputParser.new(File.read(File.dirname(__FILE__) + '/ab_output.txt'))
	end

	it "should get the mean time per request" do
		@parser.mean_time_per_request.should == "177.100"
	end
	
	it "should get the mean concurrent time per request" do 
		@parser.mean_concurrent_time_per_request.should == "35.400"
	end
	
end