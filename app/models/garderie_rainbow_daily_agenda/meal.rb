class GarderieRainbowDailyAgenda
  class Meal < Struct.new(:meal_type, :a_bit, :one_serving, :two_servings,
                    keyword_init: true)
    # TODO remove redundancy if not needed
#     ATTRIBUTES = [:meal_type, :a_bit, :one_serving, :two_servings]
#     attr_accessor *ATTRIBUTES
#     rubyserial_only *ATTRIBUTES
  end
end
