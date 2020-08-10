$LOAD_PATH.unshift(File.expand_path('..', __FILE__))

require 'bundler/setup'
Bundler.require(:default)
Glimmer::Config.logging_devices = [:stdout, :file, :syslog]
require 'puts_debuggerer'
require 'active_support/core_ext/string/output_safety'
require 'date'
require 'views/garderie_rainbow_daily_agenda/app_view'

# TODO on focus of any widget, scroll to it

class GarderieRainbowDailyAgenda
  include Glimmer

  APP_ROOT = File.expand_path('../..', __FILE__)        
  VERSION = File.read(File.join(APP_ROOT, 'VERSION'))
  LICENSE = File.read(File.join(APP_ROOT, 'LICENSE.txt'))
  
  class << self
    def email_sender
      @email_sender ||= MailHandler.sender(:smtp) do |dispatcher|
        dispatcher.address = 'smtp.gmail.com'
        dispatcher.port = 587
        dispatcher.domain = 'gmail.com'
        dispatcher.username = ENV['username']
        dispatcher.password = ENV['password']
        dispatcher.use_ssl = true
      end  
    end
  
  end
    
  def open    
    app_view.open
  end
end
