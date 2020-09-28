class GarderieRainbowDailyAgenda    
  class Drink                     
     
    attr_accessor :milk_time, :fluid_amount
    
    def milk_time_string
      milk_time&.strftime('%I:%M %p')
    end
  end
end
