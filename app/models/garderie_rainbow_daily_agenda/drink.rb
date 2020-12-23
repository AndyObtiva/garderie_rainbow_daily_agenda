class GarderieRainbowDailyAgenda    
  class Drink                            
#     include ActiveModel::Model
    include Glimmer
    
    ATTRIBUTES = [ :milk_time, :fluid_amount ]
    attr_accessor :milk_time_java, *ATTRIBUTES
#     rubyserial_only *ATTRIBUTES
    
#     validates :milk_time, presence: true
#     validates :fluid_amount, presence: true
    
    def initialize
      observe(self, :milk_time) do |new_value|
        notify_observers(:milk_time_string)
      end
    end
    
    def milk_time_string
      milk_time&.strftime('%I:%M %p')
    end
    
    def milk_time
      Time.at(milk_time_java.time / 1000.0) unless milk_time_java.nil?
    end    
  end
end
