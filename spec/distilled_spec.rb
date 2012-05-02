require 'spec_helper'

describe ApplicationController, :type => :controller do
  # before(:each) do
  #   @test_log_path = 'spec/dummy/log/test.log'
  #   File.open(@test_log_path, 'w') {}
  #   Rails.logger = Distilled::DistilledLogger.new(Rails.application, {filtered_ips: ['127.0.0.1', '168.192.0.0']})
  # end

  describe "Distilled Logger" do
    it "should use Rails.logger as default" do
      @rails_logger = mock('rails_logger')
      Rails.stub(:logger).and_return(@rails_logger)
      @dl = Distilled::DistilledLogger.new(Rails.application, {filtered_ips: ['127.0.0.1', '168.192.0.0']})

      logfile = dl.determine_log_file('foo')
      logfile.should == @rails_logger
    end

    it "should use nil logger if IP is within filter" do
      @nil_logger = mock('nil_logger')
      Logger.stub(:new).and_return(@nil_logger)
      @request = mock('request')
      @request.stub(:ip).and_return('127.0.0.1')
      ActionDispatch::Request.stub(:new).and_return(@request)
      @dl = Distilled::DistilledLogger.new(Rails.application, {filtered_ips: ['127.0.0.1', '168.192.0.0']})

      logfile = dl.determine_log_file('foo')
      logfile.should == @nil_logger
    end
  end

end