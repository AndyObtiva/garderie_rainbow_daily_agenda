class GarderieRainbowDailyAgenda
  class Mood < Struct.new(:very_happy, :happy, :unsure, :sad,
                    keyword_init: true)
  end
end
