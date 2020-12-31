class GarderieRainbowDailyAgenda
  class PottyTime < Struct.new(:change_time, :wet, :bm, :diaper, :toilet,
                                keyword_init: true)
    
    def change_time_string
      change_time&.strftime('%I:%M %p')
    end
  end
end
