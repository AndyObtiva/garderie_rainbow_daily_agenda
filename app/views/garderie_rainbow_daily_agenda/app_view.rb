class GarderieRainbowDailyAgenda
  class AppView
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
      Display.setAppName('Garderie Rainbow Daily Agenda')
      Display.setAppVersion(VERSION)
      @display = display {
        on_about {
          display_about_dialog
        }
        on_preferences {
          display_preferences_dialog
        }
      }
      @image_baby_milk_bottle = image(File.join(APP_ROOT, 'images', 'baby_milk_bottle.png'))
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
      shell(:no_resize) {
        grid_layout {
          margin_width 15
          margin_height 15
          vertical_spacing 15
        }
        minimum_size 640, 480
        image File.join(APP_ROOT, 'package', 'windows', "Garderie Rainbow Daily Agenda.ico") if OS.windows?
        text "Garderie Rainbow Daily Agenda"
        
        menu_bar {
          menu {
            text '&File'
            menu_item {
              text 'Preferences...'
              on_widget_selected {
                display_preferences_dialog
              }
            }
          }
        }
        
        label {
          layout_data(:left, :center, false, false)
          font height: 24
          text 'Garderie Rainbow'
        }
        label {
          layout_data(:left, :center, false, false) {
            width_hint 212
            height_hint 100
          }
          background_image File.join(APP_ROOT, 'images', 'garderie_rainbow_daily_agenda_logo.png')
        }
        label {
          layout_data(:left, :center, false, false)
          font height: 24
          text 'Agenda Quotidien / Daily Agenda'
        }
        label {
          layout_data(:left, :center, false, false)
          font height: 18
          text "Nom de l’enfant / Child's Name: "
        }
        text {
          layout_data(:fill, :center, true, false)
          font height: 18
          on_focus_gained { |event|
            event.widget.select_all
          }
        }
        
        composite {
          font height: 18
          grid_layout(4, false) {
            margin_width 0
            margin_height 0
          }
          
          # row
          
          label {
            layout_data(:left, :center, false, false) {
              horizontal_span 4
            }
            font height: 18, style: :bold
            text "Ce que j'ai mangé aujourd'hui / What I ate Today"
            foreground rgb(239, 190, 45)
          }
          
          # row
          
          label {
            text 'Repas / Meal'
            font height: 16, style: :bold
          }
          
          label {
            layout_data {
              horizontal_span 3
            }
            text "J’ai mangé/How much I ate"
            font height: 16, style: :bold
          }
          
          # row
          
          label {
            text "Déjeuner/Breakfast🥐🍞"
            font height: 16
          }
          
          #TODO extract the following into a custom widget
        
          group {
            row_layout
            
            layout_data {
              horizontal_span 3
            }
              
            button(:radio) {
              text 'Un peu/A bit'
              font height: 16            
            }
        
            button(:radio) {
              text '1 Portion/serving'
              font height: 16          
            }
            
            button(:radio) {
              text '2 Portions/servings'
              font height: 16          
            }           
          }  
          
          # row
          
          label {
            text "Dîner/Lunch 🍽🍗🍲"
            font height: 16
          }
                             
          group {
            row_layout
            
            layout_data {
              horizontal_span 3
            }
              
            button(:radio) {
              text 'Un peu/A bit'
              font height: 16            
            }
        
            button(:radio) {
              text '1 Portion/serving'
              font height: 16          
            }
            
            button(:radio) {
              text '2 Portions/servings'
              font height: 16          
            }           
          }  
          
          # row 5
          
          label {
            text "Collation d’aprés midi/PM Snack 🍎🍐🍌🍉"
            font height: 16
          }          
          
          group {
            row_layout
            
            layout_data {              
              horizontal_span 3
            }          
            
            button(:radio) {
              text 'Un peu/A bit'
              font height: 16            
            }
        
            button(:radio) {
              text '1 Portion/serving'
              font height: 16          
            }
            
            button(:radio) {
              text '2 Portions/servings'
              font height: 16          
            }           
          }  
        }
    
        composite {
          font height: 18
          grid_layout {
            margin_width 0
            margin_height 0
          }
          
          label {
            layout_data(:left, :center, false, false)
            font height: 18, style: :bold
            text "Comment j’ai bu / How much I drank"
            foreground rgb(98, 174, 88)
          }
          
          table { |table_proxy|
            layout_data(:fill, :center, true, false)
            font height: 18, style: :bold
            item_count 3
            
            table_column {
              width 400
              text "L’heure du lait /milk time"
              image @image_baby_milk_bottle.scale_to(24, 24)
            }
            table_column {
              width 400
              text "Combien de fluide/How much fluid"
            }
                        
            on_mouse_up { |event|
              table_proxy.edit_table_item(event.table_item, event.column_index)
            }          
          }
        
        }         
                
      }
    
    }

    def display_about_dialog
      message_box(body_root) {
        text 'About'
        message "Garderie Rainbow Daily Agenda - App View #{VERSION}\n\n#{LICENSE}"
      }.open
    end
    
    def display_preferences_dialog
      dialog(swt_widget) {
        text 'Preferences'
        grid_layout {
          margin_height 5
          margin_width 5
        }
        group {
          row_layout {
            type :vertical
            spacing 10
          }
          text 'Greeting'
          font style: :bold
          [
            'Hello, World!', 
            'Howdy, Partner!'
          ].each do |greeting_text|
            button(:radio) {
              text greeting_text
              selection bind(self, :greeting) { |g| g == greeting_text }
              layout_data {
                width 160
              }
              on_widget_selected { |event|
                self.greeting = event.widget.getText
              }
            }
          end
        }
      }.open
    end
  end
end
