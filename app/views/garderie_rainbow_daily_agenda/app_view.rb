require 'views/garderie_rainbow_daily_agenda/meal_serving_radio_group.rb'

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
      @image_sleeping_baby = image(File.join(APP_ROOT, 'images', 'sleeping_baby.gif'))
      @image_diaper = image(File.join(APP_ROOT, 'images', 'diaper.gif'))
      @image_doll_on_toilet = image(File.join(APP_ROOT, 'images', 'doll_on_toilet.gif'))
      @image_smilie_big_smile = image(File.join(APP_ROOT, 'images', 'smilie_big_smile.gif'))
      @image_smilie_smile = image(File.join(APP_ROOT, 'images', 'smilie_smile.gif'))
      @image_smilie_unsure = image(File.join(APP_ROOT, 'images', 'smilie_unsure.gif'))
      @image_smilie_sad = image(File.join(APP_ROOT, 'images', 'smilie_sad.gif'))
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
      shell {
        minimum_size 800, 600
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
        
        scrolled_composite {
          
          composite {                        
            # top header
            
            label {
              layout_data(:center, :center, false, false)
              font height: 24
              text 'Garderie Rainbow'
            }
            label {
              layout_data(:center, :center, false, false) {
                width_hint 212
                height_hint 100
              }
              background_image File.join(APP_ROOT, 'images', 'garderie_rainbow_daily_agenda_logo.png')
            }
            label {
              layout_data(:center, :center, false, false)
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
            
              meal_serving_radio_group
              
              # row
              
              label {
                text "Dîner/Lunch 🍽🍗🍲"
                font height: 16
              }
                                 
              meal_serving_radio_group
                        
              # row
              
              label {
                text "Collation d’aprés midi/PM Snack 🍎🍐🍌🍉"
                font height: 16
              }          
              
              meal_serving_radio_group
            }
        
            composite {
              grid_layout {
                margin_width 0
              }
              
              label {
                layout_data(:left, :center, false, false)
                font height: 18, style: :bold
                text "Comment j’ai bu / How much I drank"
                foreground rgb(98, 174, 88)
              }
              
              composite {
                grid_layout(3, false) {
                  margin_width 0
                  margin_height 0
                }
                
                layout_data(:fill, :top, true, false) 
                        
                # row

                composite {
                  grid_layout(2, false) {
                    margin_width 0
                    margin_height 0
                  }
                  layout_data(:left, :bottom, false, false) {
                    width_hint 395
                  }
                  label {
                    image @image_baby_milk_bottle.scale_to(48, 48)
                  }
                  label {
                    layout_data(:left, :bottom, false, false)
                    font height: 16, style: :bold
                    text "L’heure du lait /milk time"
                    foreground rgb(98, 174, 88)
                  }
                            
                }
                
                label {
                  layout_data(:left, :bottom, false, false) {
                    width_hint 393
                  }
                  font height: 16, style: :bold
                  text "Combien de fluide/How much fluid"
                  foreground rgb(98, 174, 88)
                }
                          
                label # filler
                          
                # row
                          
                text {
                  layout_data(:left, :center, false, false) {
                    width_hint 395
                  }
                }
                
                text {
                  layout_data(:left, :center, false, false) {
                    width_hint 393
                  }
                }
                
                button {
                  text '&Add'
                }
                      
              }
              
              table { |table_proxy|
                layout_data(:fill, :center, true, false)
                font height: 16
                item_count 3                
                header_visible false
                                
                table_column {
                  width 400
                }
                table_column {
                  width 400
                }
                            
                on_mouse_up { |event|
                  table_proxy.edit_table_item(event.table_item, event.column_index)
                }          
              }
            
            }
            
            composite {
              row_layout
              layout_data(:left, :center, false, false)
              
              label {         
                font height: 18, style: :bold
                text "Sieste/Naptime:"
                foreground rgb(85, 114, 192)
              }
              
              composite {
                layout_data {
                  width 48
                  height 48         
                }         
                background :transparent
                background_image @image_sleeping_baby.scale_to(48, 48)
              }
            }
            
            composite {
              row_layout
            
              composite {
                label {     
                  layout_data(:left, :center, false, false)    
                  font height: 16
                  text "Je me suis endormi à / I fell asleep at:"
                }               
                        
                c_date_time(CDT::BORDER | CDT::SIMPLE | CDT::CLOCK_24_HOUR | CDT::TIME_MEDIUM)                  
              }
            
              composite {
                label {         
                  font height: 16
                  text "Jusqu’à / Until:"
                }
                
                c_date_time(CDT::BORDER | CDT::SIMPLE | CDT::CLOCK_24_HOUR | CDT::TIME_MEDIUM)                 
              }
              
            }
                     
            composite {
              grid_layout {
                margin_width 0
              }
              
              label {
                layout_data(:left, :center, false, false)
                font height: 18, style: :bold
                text "Temps à la toilette / Potty times:"
                foreground rgb(98, 51, 156)
              }
              
              composite {
                grid_layout(6, false) {
                  margin_width 0
                  margin_height 0
                }                
                
                layout_data(:fill, :top, true, false) 
                        
                # row
                
                label {
                  layout_data(:left, :bottom, false, false) {
                    width_hint 155
                  }
                  font height: 16, style: :bold
                  text "L’heure change /\nTime changed"
                  foreground rgb(98, 174, 88)
                }
                          
                label {
                  layout_data(:left, :bottom, false, false) {
                    width_hint 153
                  }
                  font height: 16, style: :bold
                  text "Mouillé/Wet"
                  foreground rgb(98, 174, 88)
                }
                          
                label {
                  layout_data(:left, :bottom, false, false) {
                    width_hint 151
                  }
                  font height: 16, style: :bold
                  text "BM"
                  foreground rgb(98, 174, 88)
                }
                         
                composite {
                  row_layout {
                    margin_width 0
                    margin_height 0                  
                  }
                  layout_data(:left, :bottom, false, false) {
                    width_hint 151
                  }
                  label {
                    image @image_diaper.scale_to(80, 80)
                  }
                  label {
                    font height: 16, style: :bold
                    text "Couche/Diaper"
                    foreground rgb(98, 174, 88)
                  }                            
                } 
                
                composite {
                  row_layout {
                    margin_width 0
                    margin_height 0                  
                  }
                  layout_data(:left, :bottom, false, false) {
                    width_hint 151
                  }
                  label {
                    image @image_doll_on_toilet.scale_to(80, 80)
                  }
                  label {
                    font height: 16, style: :bold
                    text "Toilette/Toilet"
                    foreground rgb(98, 174, 88)
                  }
                } 
                                          
                label # filler
                                          
                # row
                                          
                text {
                  layout_data(:left, :center, false, false) {
                    width_hint 155
                  }
                }
                
                text {
                  layout_data(:left, :center, false, false) {
                    width_hint 153
                  }
                }
                
                text {
                  layout_data(:left, :center, false, false) {
                    width_hint 151
                  }
                }
                
                text {
                  layout_data(:left, :center, false, false) {
                    width_hint 151
                  }
                }
                
                text {
                  layout_data(:left, :center, false, false) {
                    width_hint 151
                  }
                }
              
                button {
                  text 'Ad&d'
                }
      
              }
              
              
              table { |table_proxy|
                layout_data(:fill, :center, true, false)
                font height: 16
                item_count 3
                header_visible false
                
                table_column {
                  width 160
                }                            
                table_column {
                  width 160
                }                            
                table_column {
                  width 160
                }
                table_column {
                  width 160
                }                            
                table_column {
                  width 160
                }
                 
                on_mouse_up { |event|
                  table_proxy.edit_table_item(event.table_item, event.column_index)
                }          
              }
            
            }   
            
            composite {
              
              label {         
                font height: 18, style: :bold
                text "Mon humeur était / My mood was:"
                foreground rgb(99, 175, 237)
              }
              
              
              group {
                row_layout
                radio {
                  image @image_smilie_big_smile.scale_to(64, 64)
                }
                radio {
                  image @image_smilie_smile.scale_to(64, 64)
                }
                radio {
                  image @image_smilie_unsure.scale_to(64, 64)
                }
                radio {
                  image @image_smilie_sad.scale_to(64, 64)
                }
              }
            }
                        
            composite {
              layout_data(:fill, :center, true, false)
              
              label {         
                font height: 18, style: :bold
                text "S'il vous plaît amenez/Please bring:"
                foreground rgb(223, 90, 243)
              }              
              
              checkbox {
                font height: 18, style: :bold
                text 'Couche/Diapers'
              }
              checkbox {
                font height: 18, style: :bold
                text 'Vêtements supplémentaires/Extra clothes'
              }
              checkbox {
                font height: 18, style: :bold
                text 'Lait ou formule spéciale/Special milk or formula'
              }
              checkbox {
                font height: 18, style: :bold
                text 'Lingettes/Wipes'
              }
            
              label {
                font height: 18, style: :bold
                text 'Autre/Other:'
              }
              
              text {
                layout_data(:fill, :center, true, false)
              }
            
            }
                                                                                                                                                                                                          
            label {
              layout_data(:left, :center, false, false)
              font height: 18
              text "Je me suis amusé quand/I had fun when we:"
            }
            text {
              layout_data(:fill, :center, true, false)
              font height: 18
              on_focus_gained { |event|
                event.widget.select_all
              }
            }
            
            label {
              layout_data(:left, :center, false, false)
              font height: 18
              text "Notes spéciales / Special notes:"
            }
            text {
              layout_data(:fill, :center, true, false)
              font height: 18
              on_focus_gained { |event|
                event.widget.select_all
              }
            }
            
            label {
              layout_data(:left, :center, false, false)
              font height: 18
              text "Nom de l’éducatrice / Educator name:"
            }
            text {
              layout_data(:fill, :center, true, false)
              font height: 18
              on_focus_gained { |event|
                event.widget.select_all
              }
            }
            
            label {
              layout_data(:left, :center, false, false)
              font height: 18, style: :bold
              text "HAVE A NICE DAY 🤗"
              foreground rgb(239, 190, 45)
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
