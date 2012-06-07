# Put this in config/application.rb
require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module Workman
  class Application < Rails::Application
    config.autoload_paths += [config.root.join('lib')]
    config.encoding = 'utf-8'
  
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
      :key => '_workman_session',
      :secret      => 'f72c63ebf34955cbff50002898e0dfd88b2059de987207493f6a4ca19921bcf23e02a0a98fb74180c559ac1f012b4dd932
  4b939d8d7888d0496c36e0f50fbf68'
    }
  
    # See User.rb for action_mailer configuration.
    config.action_mailer.raise_delivery_errors = true;
     
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
end
