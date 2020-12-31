class GarderieRainbowDailyAgenda
  class Mood < Struct.new(:very_happy, :happy, :unsure, :sad,
                    keyword_init: true)
#     ATTRIBUTES = [ :very_happy, :happy, :unsure, :sad ]
#     attr_accessor *ATTRIBUTES
#     rubyserial_only *ATTRIBUTES
  end
end
