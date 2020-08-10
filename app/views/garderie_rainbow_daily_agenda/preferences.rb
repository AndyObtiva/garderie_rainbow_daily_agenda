class GarderieRainbowDailyAgenda
  class Preferences
    include Glimmer::UI::CustomShell
    
    ## Add options like the following to configure CustomShell by outside consumers
    #
    # options :title, :background_color
    # option :width, default: 320
    # option :height, default: 240
    option :greeting, default: 'Hello, World!'

    ## Use before_body block to pre-initialize variables to use in body
    #
    #
    # before_body {
    #
    # }

    ## Use after_body block to setup observers for widgets in body
    #
    # after_body {
    # 
    # }

    ## Add widget content inside custom shell body
    ## Top-most widget must be a shell or another custom shell
    #
    body {
      dialog {
        # Replace example content below with custom shell content
        minimum_size 320, 240
        image File.join(APP_ROOT, 'package', 'windows', "Garderie Rainbow Daily Agenda.ico") if OS.windows?
        text "Garderie Rainbow Daily Agenda - Preferences"
        
        fill_layout
                
        group {
          grid_layout 3, false
          font height: 18, style: :bold
          text 'Email Settings'
          
          label {
            text 'SMTP Server Address:'            
            font height: 16
          }          
          text {
            layout_data(:fill, :top, true, false) {
              width_hint 160
            }
            font height: 16
          }
          label # filler
                    
          label {
            text 'Port:'
            font height: 16
          }          
          text {
            layout_data(:fill, :top, true, false)
            font height: 16
          }                    
          checkbox {
            layout_data(:left, :top, false, false)
            text 'SSL?'
            font height: 16
          }
                    
          label {
            text 'Username/Email:'
            font height: 16
          }          
          text {
            layout_data(:fill, :top, true, false)
            font height: 16
          }
          label # filler
                    
          label {
            text 'Password:'
            font height: 16
          }          
          text(:password, :border) {
            layout_data(:fill, :top, true, false)
            font height: 16
          }
          label # filler
          
          label {
            text 'From Email Address:'
            font height: 16
          }          
          text {
            layout_data(:fill, :top, true, false)
            font height: 16
          }
          label # filler
          
          label {
            text 'From Name:'
            font height: 16
          }          
          text {
            layout_data(:fill, :top, true, false)
            font height: 16
          }
          label # filler
          
        }                
        
      }
    }
  end
end
