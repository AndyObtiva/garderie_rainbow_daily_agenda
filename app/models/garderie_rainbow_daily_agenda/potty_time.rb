class GarderieRainbowDailyAgenda
  class PottyTime < Struct.new(:change_time, :wet, :bm, :diaper, :toilet,
                                keyword_init: true)
    include ActiveModel::Model
    
    validates :change_time, presence: true
  end
end
