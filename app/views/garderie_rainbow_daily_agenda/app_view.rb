require 'models/garderie_rainbow_daily_agenda/child'
require 'models/garderie_rainbow_daily_agenda/drink'
require 'models/garderie_rainbow_daily_agenda/email_message'
require 'services/garderie_rainbow_daily_agenda/email_service'
require 'views/garderie_rainbow_daily_agenda/meal_serving_radio_group'
require 'views/garderie_rainbow_daily_agenda/preferences'

class GarderieRainbowDailyAgenda
  class AppView
    include Glimmer::UI::CustomShell
    
    ## Add options like the following to configure CustomShell by outside consumers
    #
    # options :title, :background_color
    # option :width, default: 320
    # option :height, default: 240
    option :greeting, default: 'Hello, World!'

    attr_accessor :child

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
          preferences.open
        }
        on_swt_keyup { |event|
          event.widget.shell.close if event.keyCode == swt(:esc) && event.widget.shell.get_data('proxy').has_style?(:dialog_trim)
        }
      }
      @image_baby_milk_bottle = image(File.join(APP_ROOT, 'images', 'baby_milk_bottle.png'))
      @image_milk_glass = image(File.join(APP_ROOT, 'images', 'milk_glass.png'))
      @image_sleeping_baby = image(File.join(APP_ROOT, 'images', 'sleeping_baby.png'))
      @image_diaper = image(File.join(APP_ROOT, 'images', 'diaper.png'))
      @image_doll_on_toilet = image(File.join(APP_ROOT, 'images', 'doll_on_toilet.gif'))
      @image_smilie_big_smile = image(File.join(APP_ROOT, 'images', 'smilie_big_smile.gif'))
      @image_smilie_smile = image(File.join(APP_ROOT, 'images', 'smilie_smile.gif'))
      @image_smilie_unsure = image(File.join(APP_ROOT, 'images', 'smilie_unsure.png'))
      @image_smilie_sad = image(File.join(APP_ROOT, 'images', 'smilie_sad.png'))
      @child = Child.new
      @meal_serving_radio_groups = {}
      @new_drink_labels = {}
      @new_drink_inputs = {}
      @new_potty_time_labels = {}
      @new_potty_time_inputs = {}
      @required_labels = {}
      @required_inputs = {}
      
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
      shell {
        minimum_size 800, 600
        image File.join(APP_ROOT, 'package', 'windows', "Garderie Rainbow Daily Agenda.ico") if OS.windows?
        text "Garderie Rainbow Daily Agenda"
        
        menu_bar {
          menu {
            text '&File'
            menu_item {
              text '&Preferences...'
              on_widget_selected {
                preferences.open
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
            
            @required_labels[:name] = label {
              layout_data(:left, :center, false, false)
              font height: 18
              text "Nom de l’enfant / Child's Name: "
            }
            @initial_focus_widget = @required_inputs[:name] = text {
              layout_data(:fill, :center, true, false)
              font height: 18
              text bind(self, 'child.name')
              focus true
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
            
              @meal_serving_radio_groups[:breakfast] = meal_serving_radio_group(meal: @child.meals[:breakfast])
              
              # row
              
              label {
                text "Dîner/Lunch 🍽🍗🍲"
                font height: 16
              }
                                 
              @meal_serving_radio_groups[:lunch] = meal_serving_radio_group(meal: @child.meals[:lunch])
                        
              # row
              
              label {
                text "Collation d’aprés midi/PM Snack 🍎🍐🍌🍉"
                font height: 16
              }          
              
              @meal_serving_radio_groups[:pm_snack] = meal_serving_radio_group(meal: @child.meals[:pm_snack])
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
                  grid_layout(3, false) {
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
                    image @image_milk_glass.scale_to(48, 48)
                  }                
                  @new_drink_labels[:milk_time] = label {
                    layout_data(:left, :bottom, false, false)
                    font height: 16, style: :bold
                    text "L’heure du lait /milk time"
                    foreground rgb(98, 174, 88)
                  }
                            
                }
                
                @new_drink_labels[:fluid_amount] = label {
                  layout_data(:left, :bottom, false, false) {
                    width_hint 393
                  }
                  font height: 16, style: :bold
                  text "Combien de fluide/How much fluid"
                  foreground rgb(98, 174, 88)
                }
                          
                label # filler
                          
                # row
                          
                @new_drink_inputs[:milk_time] = c_date_time(CDT::BORDER | CDT::DROP_DOWN | CDT::TIME_MEDIUM) {
                  layout_data(:left, :center, false, false) {
                    width_hint 395
                  }
                  pattern 'hh:mm a'
                  selection bind(self, 'child.new_drink.milk_time')                  
                  on_key_pressed { |event|
                    @new_drink_inputs[:fluid_amount].swt_widget.set_focus if event.keyCode == swt(:cr)
                  }                               
                }
                
                @new_drink_inputs[:fluid_amount] = text {
                  layout_data(:left, :center, false, false) {
                    width_hint 393
                  }
                  text bind(self, 'child.new_drink.fluid_amount')
                  on_key_pressed { |event|
                    add_drink if event.keyCode == swt(:cr)
                  }                               
                }
                
                @new_drink_add_button = button {                  
                  text '&Add'
                  on_key_pressed { |event|
                    add_drink if event.keyCode == swt(:cr)
                  }                               
                  on_widget_selected {
                    add_drink
                  }                
                }                                
                      
              }
              
              @drink_table = table(:multi) { |table_proxy|
                layout_data(:fill, :center, true, false)
                font height: 16
                item_count 3                
                header_visible false
                                
                table_column {
                  width 400
                  editor :c_date_time, CDT::BORDER | CDT::DROP_DOWN | CDT::TIME_MEDIUM, property: :milk_time
                }
                table_column {
                  width 400
                }
                            
                items bind(self, 'child.drinks'), column_properties(:milk_time_string, :fluid_amount)
                            
                on_mouse_up { |event|
                  table_proxy.edit_table_item(event.table_item, event.column_index)
                }
                        
                menu {
                  menu_item {
                    text "Remove"
                    on_widget_selected { |event|
                      @child.remove_drinks(@drink_table.swt_widget.selection.map(&:data))                      
                    }
                  }
                }                                    
              }
            
            }
            
            composite {
              grid_layout(2, false) {
                margin_width 0
                margin_height 0
              }
              layout_data(:left, :center, false, false)
              
              label {         
                layout_data(:left, :center, false, false)
                font height: 18, style: :bold
                text "Sieste/Naptime:"
                foreground rgb(85, 114, 192)
              }
              
              label {
                layout_data(:left, :center, false, false)
                image @image_sleeping_baby.scale_to(75, 75)
              }
            }
            
            composite {
              row_layout
            
              composite {
                row_layout {
                  pack true
                }
                
                label {     
                  layout_data(:left, :center, false, false)    
                  font height: 16
                  text "Je me suis endormi à / I fell asleep at:"
                }               
                        
                c_date_time(CDT::BORDER | CDT::DROP_DOWN | CDT::TIME_MEDIUM) {
                  selection bind(self, 'child.nap_time_start')
                  pattern 'hh:mm a'
                }
              }
            
              composite {
                row_layout {
                  pack true
                }
                
                label {         
                  font height: 16
                  text "Jusqu’à / Until:"
                }
                
                c_date_time(CDT::BORDER | CDT::DROP_DOWN | CDT::TIME_MEDIUM) {
                  selection bind(self, 'child.nap_time_end')
                  pattern 'hh:mm a'
                }
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
                
                @new_potty_time_labels[:changed_time] = label {
                  layout_data(:left, :bottom, false, false) {
                    width_hint 155
                  }
                  font height: 16, style: :bold
                  text "L’heure change /\nTime changed"
                  foreground rgb(98, 174, 88)
                }
                          
                @new_potty_time_labels[:wet] = label {
                  layout_data(:left, :bottom, false, false) {
                    width_hint 153
                  }
                  font height: 16, style: :bold
                  text "Mouillé/Wet"
                  foreground rgb(98, 174, 88)
                }
                          
                @new_potty_time_labels[:bm] = label {
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
                  @new_potty_time_labels[:diaper] = label {
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
                  @new_potty_time_labels[:toilet] = label {
                    font height: 16, style: :bold
                    text "Toilette/Toilet"
                    foreground rgb(98, 174, 88)
                  }
                } 
                                          
                label # filler
                                          
                # row
                                          
                @new_potty_time_inputs[:change_time] = c_date_time(CDT::BORDER | CDT::DROP_DOWN | CDT::TIME_MEDIUM) {
                  layout_data(:left, :center, false, false) {
                    width_hint 155
                  }
                  pattern 'hh:mm a'
                  selection bind(self, 'child.new_potty_time.change_time')
                  on_key_pressed { |event|
                    @new_potty_time_inputs[:wet].swt_widget.set_focus if event.keyCode == swt(:cr)
                  }                               
                }
                
                @new_potty_time_inputs[:wet] = checkbox {
                  layout_data(:left, :center, false, false) {
                    width_hint 153
                  }
                  selection bind(self, 'child.new_potty_time.wet')
                  on_key_pressed { |event|
                    @new_potty_time_inputs[:bm].swt_widget.set_focus if event.keyCode == swt(:cr)
                  }                               
                }
                
                @new_potty_time_inputs[:bm] = checkbox {
                  layout_data(:left, :center, false, false) {
                    width_hint 151
                  }
                  selection bind(self, 'child.new_potty_time.bm')
                  on_key_pressed { |event|
                    @new_potty_time_inputs[:diaper].swt_widget.set_focus if event.keyCode == swt(:cr)
                  }                               
                }
                
                @new_potty_time_inputs[:diaper] = checkbox {
                  layout_data(:left, :center, false, false) {
                    width_hint 151
                  }
                  selection bind(self, 'child.new_potty_time.diaper')
                  on_key_pressed { |event|
                    @new_potty_time_inputs[:toilet].swt_widget.set_focus if event.keyCode == swt(:cr)
                  }                               
                }
                
                @new_potty_time_inputs[:toilet] = checkbox {
                  layout_data(:left, :center, false, false) {
                    width_hint 151
                  }
                  selection bind(self, 'child.new_potty_time.toilet')
                  on_key_pressed { |event|
                    add_potty_time if event.keyCode == swt(:cr)
                  }                               
                }
              
                button {
                  text 'Ad&d'
                  on_key_pressed { |event|
                    add_potty_time if event.keyCode == swt(:cr)
                  }                               
                  on_widget_selected {
                    add_potty_time
                  }                
                }
      
              }
              
              
              @potty_time_table = table(:multi) { |table_proxy|
                layout_data(:fill, :center, true, false)
                font height: 16
                item_count 3
                header_visible false
                
                table_column {
                  width 160
                  editor :c_date_time, CDT::BORDER | CDT::DROP_DOWN | CDT::TIME_MEDIUM, property: :change_time
                }                                              
                table_column {
                  width 160
                  editor :checkbox
                }                            
                table_column {
                  width 160
                  editor :checkbox
                }
                table_column {
                  width 160
                  editor :checkbox
                }                            
                table_column {
                  width 160
                  editor :checkbox
                }
                 
                items bind(self, 'child.potty_times'), column_properties(:change_time_string, :wet, :bm, :diaper, :toilet)
                 
                on_mouse_up { |event|
                  table_proxy.edit_table_item(event.table_item, event.column_index)
                }  
              
                menu {
                  menu_item {
                    text "Remove"
                    on_widget_selected { |event|
                      @child.remove_potty_times(@potty_time_table.swt_widget.selection.map(&:data))                      
                    }
                  }
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
                  selection bind(self, 'child.mood.very_happy')         
                }
                radio {
                  image @image_smilie_smile.scale_to(64, 64)
                  selection bind(self, 'child.mood.happy')
                }
                radio {
                  image @image_smilie_unsure.scale_to(64, 64)
                  selection bind(self, 'child.mood.unsure')
                }
                radio {
                  image @image_smilie_sad.scale_to(64, 64)
                  selection bind(self, 'child.mood.sad')
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
                selection bind(self, 'child.bring_diapers')
              }
              checkbox {
                font height: 18, style: :bold
                text 'Vêtements supplémentaires/Extra clothes'
                selection bind(self, 'child.bring_extra_clothes')
              }
              checkbox {
                font height: 18, style: :bold
                text 'Lait ou formule spéciale/Special milk or formula'
                selection bind(self, 'child.bring_special_milk_or_formula')
              }
              checkbox {
                font height: 18, style: :bold
                text 'Lingettes/Wipes'
                selection bind(self, 'child.bring_wipes')
              }
            
              label {
                font height: 18, style: :bold
                text 'Autre/Other:'
              }
              
              text {
                layout_data(:fill, :center, true, false)
                text bind(self, 'child.bring_other')
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
              text bind(self, 'child.i_had_fun_when_we')
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
              text bind(self, 'child.special_notes')
              on_focus_gained { |event|
                event.widget.select_all
              }
            }
            
            @required_labels[:educator_name] = label {
              layout_data(:left, :center, false, false)
              font height: 18
              text "Nom de l’éducatrice / Educator name:"
            }
            @required_inputs[:educator_name] = text {
              layout_data(:fill, :center, true, false)
              font height: 18
              text bind(self, 'child.educator_name')
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
            
            @required_labels[:email] = label {
              layout_data(:left, :center, false, false)
              font height: 18
              text "Courriel / Email:"
            }
            @required_inputs[:email] = text {
              layout_data(:fill, :center, true, false)
              font height: 18
              text bind(self, 'child.email')
              on_focus_gained { |event|
                event.widget.select_all
              }
              on_key_pressed { |event|
                send_email if event.keyCode == swt(:cr)
              }                               
            }
            composite {
              row_layout {
                margin_width 0
                margin_height 0
                margin_left 0
                margin_right 0
                margin_top 15
                margin_bottom 0                          
              }
              layout_data(:left, :center, false, false)
              button {
                text 'Send'
                font height: 14
                on_key_pressed { |event|
                  send_email if event.keyCode == swt(:cr)
                }                               
                on_widget_selected {
                  send_email
                }
              }
              button {
                text 'Clear Form'
                font height: 14
                on_key_pressed { |event|
                  reset if event.keyCode == swt(:cr)
                }                               
                on_widget_selected {
                  reset
                }
              }
            }
                                                                                                                                                                                                                                                                                                                                                                
                                                                                                                                                                                                          
          } 
        
        }              
            
      }
            
    }
    
    def add_drink
      new_drink = @child.new_drink
      if new_drink.valid?
        @child.add_drink
        @new_drink_inputs[:milk_time].swt_widget.set_focus
      else
        @new_drink_inputs[new_drink.errors.keys.first].swt_widget.set_focus
      end
      @new_drink_labels.each do |attribute, label|
        label.content {
          foreground new_drink.errors.keys.include?(attribute) ? :red : :black
          tool_tip_text new_drink.errors.keys.include?(attribute) ? new_drink.errors[attribute].first : nil
        }
      end
    end    
       
    def add_potty_time
      new_potty_time = @child.new_potty_time
      if new_potty_time.valid?
        @child.add_potty_time
        @new_potty_time_inputs[:change_time].swt_widget.set_focus
      else
        @new_potty_time_inputs[new_potty_time.errors.keys.first].swt_widget.set_focus
      end
      @new_potty_time_labels.each do |attribute, label|
        label.content {
          foreground new_potty_time.errors.keys.include?(attribute) ? :red : :black
          tool_tip_text new_potty_time.errors.keys.include?(attribute) ? new_potty_time.errors[attribute].first : nil
        }
      end
    end       
    
    def validate
      unless @child.valid?
        @required_inputs[@child.errors.keys.first].swt_widget.set_focus
      end
      @required_labels.each do |attribute, label|
        label.content {
          foreground @child.errors.keys.include?(attribute) ? :red : :black
          tool_tip_text @child.errors.keys.include?(attribute) ? @child.errors[attribute].first : nil
        }
      end
    end
    
    def send_email
      validate
      return unless @child.valid?
      
      unless @email_service.valid?
        @preferences = preferences
        @preferences.open 
        return if @preferences.cancelled?
      end
    
      @progress_dialog = dialog {
        grid_layout(1, false)
        text body_root.shell.text
        label(:center) {
          layout_data :fill, :top, true, false
          text "Soyez Patienter / Sending Email To \"#{@child.name}\" <#{@child.email}>..."
          font height: 16
        }
        progress_bar(:indeterminate) {
          layout_data(:fill, :fill, true, true)
        }
      }

      send_email_done = false
      Thread.new do
        begin
          email_message = EmailMessage.new(@child)
          @email_service.deliver!(email_message.to_mail)
          send_email_done = true
          async_exec {
            @progress_dialog.close
          }
        rescue Exception => e
          Glimmer::Config.logger.error e.full_message
          async_exec {
            @progress_dialog.close
            message_box(body_root, :icon_error) {
              text body_root.shell.text
              message "Email Error!\n#{e.full_message}"
            }.open
          }
        end
      end
        
      @progress_dialog.open unless send_email_done
      
      if send_email_done
        message_box(body_root, :icon_information) {
          text body_root.shell.text
          message 'Email Sent!'
        }.open
        reset        
      end  
    rescue Exception => e
      Glimmer::Config.logger.error e.full_message
      message_box(body_root, :icon_error) {
        text body_root.shell.text
        message "Email Error!\n#{e.full_message}"
      }.open
    end
    
    def reset
      @meal_serving_radio_groups.values.each(&:reset)
      self.child = Child.new
      @initial_focus_widget.setFocus
    end

    def display_about_dialog
      message_box(body_root) {
        text 'About'
        message "Garderie Rainbow Daily Agenda #{VERSION}\n\n#{LICENSE}"
      }.open
    end    

  end
end
