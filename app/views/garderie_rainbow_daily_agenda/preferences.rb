require 'services/garderie_rainbow_daily_agenda/email_service'

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
    before_body {
      @labels = {}
      @inputs = {}
      
      @email_service = EmailService.instance
    }

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
        
        on_swt_show {
          validate
        }
        
        on_shell_closed {
          # This handles the case of being closed by hitting ESCAPE (display filter setup in app_view) or via window X button
          cancel unless @closed_from_preferences
        }
        
        fill_layout
                
        group {
          grid_layout 3, false
          font height: 18, style: :bold
          text 'Email Settings'
          
          @labels[:address] = label {
            text 'SMTP Server Address:'            
            font height: 16
          }          
          @inputs[:address] = text {
            layout_data(:fill, :top, true, false) {
              width_hint 180
            }
            font height: 16
            text bind(@email_service, :address)
            on_key_pressed { |event|
              @inputs[:port].set_focus if event.keyCode == swt(:cr)
            }                               
          }
          label # filler
                    
          @labels[:port] = label {
            text 'Port:'
            font height: 16
          }          
          @inputs[:port] = text {
            layout_data(:fill, :top, true, false)
            font height: 16
            text bind(@email_service, :port)
            on_key_pressed { |event|
              @inputs[:authentication].set_focus if event.keyCode == swt(:cr)
            }                               
          }                    
          checkbox {
            layout_data(:left, :top, false, false)
            text 'SSL?'
            font height: 16
            selection bind(@email_service, :use_ssl)
            on_key_pressed { |event|
              @inputs[:authentication].set_focus if event.keyCode == swt(:cr)
            }                               
          }
                    
          @labels[:authentication] = label {
            text 'Authentication Protocol:'
            font height: 16
          }          
          @inputs[:authentication] = text {
            layout_data(:fill, :top, true, false)
            font height: 16
            text bind(@email_service, :authentication)
            on_key_pressed { |event|
              @inputs[:username].set_focus if event.keyCode == swt(:cr)
            }                               
          }
          label # filler
                    
          @labels[:username] = label {
            text 'Username/Email:'
            font height: 16
          }          
          @inputs[:username] = text {
            layout_data(:fill, :top, true, false)
            font height: 16
            text bind(@email_service, :username)
            on_key_pressed { |event|
              @inputs[:password].set_focus if event.keyCode == swt(:cr)
            }                               
          }
          label # filler
                    
          @labels[:password] = label {
            text 'Password:'
            font height: 16
          }          
          @inputs[:password] = text(:password, :border) {
            layout_data(:fill, :top, true, false)
            font height: 16
            text bind(@email_service, :password)
            on_key_pressed { |event|
              @inputs[:from_email].set_focus if event.keyCode == swt(:cr)
            }                               
          }
          label # filler
          
          @labels[:from_email] = label {
            text 'From Email Address:'
            font height: 16
          }          
          @inputs[:from_email] = text {
            layout_data(:fill, :top, true, false)
            font height: 16
            text bind(@email_service, :from_email)
            on_key_pressed { |event|
              @inputs[:from_name].set_focus if event.keyCode == swt(:cr)
            }                               
          }
          label # filler
          
          @labels[:from_name] = label {
            text 'From Name:'
            font height: 16
          }          
          @inputs[:from_name] = text {
            layout_data(:fill, :top, true, false)
            font height: 16
            text bind(@email_service, :from_name)
            on_key_pressed { |event|
              save if event.keyCode == swt(:cr)
            }                               
          }
          label # filler
          
          composite {
            row_layout {
              margin_width 0
              margin_height 0
            }
            
            layout_data(:fill, :top, true, false) {
              horizontal_span 3
            }            
            
            button {
              text '&Save'
              font height: 16
              on_key_pressed { |event|
                save if event.keyCode == swt(:cr)
              }                               
              on_widget_selected {
                save
              }
            }
            
            button {
              text '&Cancel'
              font height: 16
              on_key_pressed { |event|
                cancel if event.keyCode == swt(:cr)
              }                               
              on_widget_selected {
                cancel
              }
            }            
          }
        }                
        
      }
    }
    
    def close
      @closed_from_preferences = true
      body_root.close
    end
    
    def cancel    
      @cancelled = true
      @email_service.reset
      close unless @closed_from_preferences
    end
    
    def validate
      unless @email_service.valid?
        @inputs[@email_service.errors.keys.first].swt_widget.set_focus
      end
      @labels.each do |attribute, label|
        label.content {
          foreground @email_service.errors.keys.include?(attribute) ? :red : :black
          tool_tip_text @email_service.errors.keys.include?(attribute) ? @email_service.errors[attribute].first : nil
        }
      end    
    end
    
    def save
      validate
      if @email_service.valid?
        @email_service.save
        close
      end
    end
    
    def cancelled?
      !!@cancelled
    end
    
    def saved?
      !cancelled?
    end
  end
end
