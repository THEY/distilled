require "distilled/version"
require "rails"

module Distilled
  class DistilledLogger < Rails::Rack::Logger

    def initialize(app, opts={})
      @app, @filtered_ips = app, opts[:filtered_ips]
      @nil_logger = Logger.new(nil)
      @rails_logger = Rails.logger

      super(app)
    end

    def call(env)
      logfile = determine_log_file(env)

      ActiveRecord::Base.logger = logfile
      ActionController::Base.logger = logfile
      Rails.logger = logfile

      super
    end

    def determine_log_file(env)
      request = ActionDispatch::Request.new(env)
      if @filtered_ips.include?(request.ip)
        return @nil_logger
      else
        return @rails_logger
      end
    end
    
  end
end