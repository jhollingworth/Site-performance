require "spec"
require File.dirname(__FILE__) + '/../lib/downloader'

describe "When I download a url" do
  before(:all) do
    downloader = Downloader.new
    @time = downloader.download_time_for("http://google.com")
  end

  it "should it should return the download time " do
    @time.should > 0
  end
end