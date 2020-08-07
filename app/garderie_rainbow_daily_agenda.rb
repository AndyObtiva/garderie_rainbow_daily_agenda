$LOAD_PATH.unshift(File.expand_path('..', __FILE__))

require 'bundler/setup'
Bundler.require(:default)
require 'puts_debuggerer'
require 'views/garderie_rainbow_daily_agenda/app_view'

class GarderieRainbowDailyAgenda
  include Glimmer

  APP_ROOT = File.expand_path('../..', __FILE__)        
  VERSION = File.read(File.join(APP_ROOT, 'VERSION'))
  LICENSE = File.read(File.join(APP_ROOT, 'LICENSE.txt'))          
            
  def open
    app_view.open
  end
end
