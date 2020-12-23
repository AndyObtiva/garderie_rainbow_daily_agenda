$LOAD_PATH.unshift(File.expand_path('..', __FILE__))

# require 'bundler/setup' unless RUBY_PLATFORM == 'opal'
# Bundler.require(:default) unless RUBY_PLATFORM == 'opal'
# Glimmer::Config.logging_devices = [:stdout, :file, :syslog] unless RUBY_PLATFORM == 'opal'

# TODO uncomment these lines for Glimmer DSL for Opal once ready
# require 'activemodel'
# require 'email_validator'
# require 'ruby-serial'
require 'glimmer-dsl-swt'
require 'glimmer-cw-cdatetime-nebula'

require 'puts_debuggerer'
require 'glimmer'
# require 'active_support/core_ext/string/output_safety'
require 'date'
require 'net/http'
# require 'ruby-serial' # TODO replace with a new JSON solution: attr_serializable (to create)
require 'views/garderie_rainbow_daily_agenda/app_view'
 
# TODO on focus of any widget, scroll to it
 
class GarderieRainbowDailyAgenda
  include Glimmer
 
  APP_ROOT = File.expand_path('../..', __FILE__)
  # TODO figure out a way to do File.read in Opal
  VERSION = '1.0.0' #File.read(File.join(APP_ROOT, 'VERSION'))
  # TODO figure out a way to do File.read in Opal
#   LICENSE = File.read(File.join(APP_ROOT, 'LICENSE.txt'))
   
  def open
#     sync_exec { # comment out for web
      @app_view = app_view
      pd @app_view, wrapper: true
#       Splash.close # comment out for web
      @app_view.open
#     } # TODO comment out for web
  end
end
