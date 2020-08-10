class GarderieRainbowDailyAgenda
  class MealServingRadioGroup
    include Glimmer::UI::CustomWidget
    
    option :meal

    ## Add options like the following to configure CustomWidget by outside consumers
    #
    # options :custom_text, :background_color
    # option :foreground_color, default: :red

    ## Use before_body block to pre-initialize variables to use in body
    #
    #
    before_body {
      @radios = {}
    }

    ## Use after_body block to setup observers for widgets in body
    #
    # after_body {
    # 
    # }

    ## Add widget content under custom widget body
    ##
    ## If you want to add a shell as the top-most widget, 
    ## consider creating a custom shell instead 
    ## (Glimmer::UI::CustomShell offers shell convenience methods, like show and hide)
    #
    body {
      group {
        row_layout
        
        layout_data {
          horizontal_span 3
        }
          
        @radios[:a_bit] = radio {
          text 'Un peu/A bit'
          font height: 16   
          selection bind(meal, :a_bit)   
        }
    
        @radios[:one_serving] = radio {
          text '1 Portion/serving'
          font height: 16          
          selection bind(meal, :one_serving)
        }
        
        @radios[:two_servings] = radio {
          text '2 Portions/servings'
          font height: 16          
          selection bind(meal, :two_servings)
        }           
      }  
    }
    
    def reset
      @radios.values.each {|radio_proxy| radio_proxy.swt_widget.selection = nil}
    end

  end
end
