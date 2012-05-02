Dummy::Application.config.middleware.swap(
  Rails::Rack::Logger, Distilled::DistilledLogger, :filtered_ips => ['127.0.0.1', '168.192.0.0']
)