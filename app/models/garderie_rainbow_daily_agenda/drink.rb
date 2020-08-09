class GarderieRainbowDailyAgenda    
  class Drink < Struct.new(:milk_time, :fluid_amount, 
                            keyword_init: true)
    include ActiveModel::Model
    
    validates :milk_time, presence: true
    validates :fluid_amount, presence: true
  end
end
