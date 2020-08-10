class GarderieRainbowDailyAgenda    
  class Drink < Struct.new(:milk_time, :fluid_amount, 
                            keyword_init: true)
    include ActiveModel::Model
    
    validates :milk_time, presence: true
    validates :fluid_amount, presence: true
    
    def milk_time_string
      return if milk_time.nil?
      Time.at(milk_time.time / 1000.0).strftime('%I:%M %p')      
    end    
  end
end
