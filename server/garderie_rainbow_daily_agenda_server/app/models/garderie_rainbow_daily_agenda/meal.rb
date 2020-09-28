class GarderieRainbowDailyAgenda
  class Meal < Struct.new(:type, :a_bit, :one_serving, :two_servings, 
                    keyword_init: true)
    attr_accessor :type, :a_bit, :one_serving, :two_servings
  end
end
