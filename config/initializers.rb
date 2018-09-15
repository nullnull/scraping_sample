require 'active_record'
require 'erb'
require 'nokogiri'
require 'pry-byebug'
require 'selenium-webdriver'
require 'slack-notifier'
require './app/models/application_record'
require './app/models/search_result'
require './app/scrapers/google_scraper'

# setup active record
config = YAML.safe_load(ERB.new(IO.read(File.expand_path('database.yml', __dir__))).result)
env = ENV.fetch('APP_ENV', 'development')
ActiveRecord::Base.establish_connection(config[env])
ActiveRecord::Base.time_zone_aware_attributes = true
Time.zone = 'Tokyo'
