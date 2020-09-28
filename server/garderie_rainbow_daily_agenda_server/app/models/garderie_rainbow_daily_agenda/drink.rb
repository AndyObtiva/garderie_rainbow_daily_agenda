class GarderieRainbowDailyAgenda    
  class Drink < Struct.new(:milk_time, :fluid_amount, 
                            keyword_init: true)                            
    
    attr_accessor :milk_time, :fluid_amount
  end
end
