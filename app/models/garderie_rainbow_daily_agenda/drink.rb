class GarderieRainbowDailyAgenda    
  class Drink < Struct.new(:milk_time, :fluid_amount, 
                            keyword_init: true)                            
    include ActiveModel::Model
    include Glimmer
    
    validates :milk_time, presence: true
    validates :fluid_amount, presence: true
    
    def initialize
      observe(self, :milk_time) do |new_value|
        notify_observers(:milk_time_string)
      end
    end
    
    def milk_time_string
      return if milk_time.nil?
      Time.at(milk_time.time / 1000.0).strftime('%I:%M %p')      
    end    
  end
end
