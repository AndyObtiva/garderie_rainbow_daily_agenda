pd 'defining class for GarderieRainbowDailyAgenda'
class GarderieRainbowDailyAgenda
  pd 'defining class for MealServingRadioGroup'
  class MealServingRadioGroup
    pd 'include Glimmer::UI::CustomWidget'
    include Glimmer::UI::CustomWidget
    pd 'option :meal'
    option :meal

    ## Add options like the following to configure CustomWidget by outside consumers
    #
    # options :custom_text, :background_color
    # option :foreground_color, default: :red

    ## Use before_body block to pre-initialize variables to use in body
    #
    #
    pd 'before_body'
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
    pd body {
      pd group {
        pd row_layout :horizontal
        
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
      @radios.values.each {|radio_proxy| radio_proxy  .selection = nil}
    end

  end
end
