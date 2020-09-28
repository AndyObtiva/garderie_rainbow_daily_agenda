class GarderieRainbowDailyAgenda
  class PottyTime
    attr_accessor :change_time, :wet, :bm, :diaper, :toilet    
    
    def change_time_string
      change_time&.strftime('%I:%M %p')      
    end
  end      
end
