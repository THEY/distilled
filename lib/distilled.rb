require "distilled/version"
require "rails"

module Distilled
  class DistilledLogger < Rails::Rack::Logger

    def initialize(app, opts={})
      puts "==> Using Distilled"
      @app, @filtered_ips = app, opts[:filtered_ips]
      @nil_logger = Logger.new(nil)
      @old_logger = Rails.logger

      super(app)
    end

    def call(env)
      request = ActionDispatch::Request.new(env)
      puts "==> IP: #{request.ip}"
      if @filtered_ips.include?(request.ip)
        logfile = @nil_logger
      else
        logfile = @old_logger
      end
      
      ActiveRecord::Base.logger = logfile
      ActionController::Base.logger = logfile
      Rails.logger = logfile

      @logger = logfile

      super
    end
    
  end
end