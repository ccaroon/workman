# Be sure to restart your web server when you modify this file.

# Uncomment below to force Rails into production mode when 
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'mislav-will_paginate', 
    :version => '~> 2.2.3',
    :lib => 'will_paginate',
    :source => 'http://gems.github.com'

  config.gem 'BlueCloth',
    :version => '~> 1.0.0',
    :lib => 'bluecloth'

  # Settings in config/environments/* take precedence over those specified here
  
  # Skip frameworks you're not going to use (only works if using vendor/rails)
  # config.frameworks -= [ :action_web_service, :action_mailer ]

  # Only load the plugins named here, by default all plugins in vendor/plugins are loaded
  # config.plugins = %W( exception_notification ssl_requirement )

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Force all environments to use the same logger level 
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug

  # Use the database for sessions instead of the file system
  # (create the session table with 'rake db:sessions:create')
  # config.action_controller.session_store = :active_record_store
  config.action_controller.session = {
    :session_key => '_workman_session',
    :secret      => 'f72c63ebf34955cbff50002898e0dfd88b2059de987207493f6a4ca19921bcf23e02a0a98fb74180c559ac1f012b4dd932
4b939d8d7888d0496c36e0f50fbf68'
  }

#   config.action_mailer.delivery_method       = :smtp;
   config.action_mailer.raise_delivery_errors = true;
# See User.rb
#   config.action_mailer.smtp_settings = {
#       :address   => 'mccexchange2.mcclatchy.com',
#       :user_name => 'USER',
#       :password  => 'PASSWD',
##------------------------------------
## NOTE: this will not work because Google require TLS
## Need to get/use the smtp_tls plugin to use Google's SMTP server
##------------------------------------
##       :address        => 'smtp.gmail.com',
##       :port           => 587,
##       :user_name      => 'USER',
##       :password       => 'PASSWD,
##------------------------------------
#       :authentication => :login,
#   };
   
  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper, 
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector

  # Make Active Record use UTC-base instead of local time
  # config.active_record.default_timezone = :utc
  
  # See Rails::Configuration for more options
end
