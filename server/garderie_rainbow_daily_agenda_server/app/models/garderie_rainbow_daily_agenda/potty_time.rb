class GarderieRainbowDailyAgenda
  class PottyTime < Struct.new(:change_time, :wet, :bm, :diaper, :toilet,
                                keyword_init: true)
    attr_accessor :change_time, :wet, :bm, :diaper, :toilet    
  end
  
end
