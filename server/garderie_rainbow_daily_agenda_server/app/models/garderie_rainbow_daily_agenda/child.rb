class GarderieRainbowDailyAgenda
  class Child
   
    attr_accessor :name, 
                  :nap_time_start, 
                  :nap_time_end,
                  :bring_diapers, 
                  :bring_extra_clothes, 
                  :bring_special_milk_or_formula, 
                  :bring_wipes, 
                  :bring_other,
                  :i_had_fun_when_we,
                  :special_notes,
                  :educator_name,
                  :email,
                  :drinks, 
                  :potty_times,
                  :meals,
                  :mood
                         
    def nap_time_start_string
      nap_time_start&.strftime('%I:%M %p')      
    end
    def nap_time_end_string
      nap_time_end&.strftime('%I:%M %p')      
    end        
 
  end
end
