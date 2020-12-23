class GarderieRainbowDailyAgenda
  class Meal < Struct.new(:type, :a_bit, :one_serving, :two_servings, 
                    keyword_init: true)
    ATTRIBUTES = [:type, :a_bit, :one_serving, :two_servings]
    attr_accessor *ATTRIBUTES
#     rubyserial_only *ATTRIBUTES
  end
end
