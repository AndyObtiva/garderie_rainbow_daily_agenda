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
  
  def open
    sync_exec {
      @app_view = app_view
      Splash.close
      @app_view.open
    }
  end
end
