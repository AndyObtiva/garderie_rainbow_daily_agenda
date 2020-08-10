class GarderieRainbowDailyAgenda
  class PottyTime < Struct.new(:change_time, :wet, :bm, :diaper, :toilet,
                                keyword_init: true)
    include ActiveModel::Model
    
    validates :change_time, presence: true
    
    def change_time_string
      return if change_time.nil?
      Time.at(change_time.time / 1000.0).strftime('%I:%M %p')      
    end    
  end
end
