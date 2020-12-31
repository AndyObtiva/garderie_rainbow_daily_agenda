class GarderieRainbowDailyAgenda
  class Meal < Struct.new(:meal_type, :a_bit, :one_serving, :two_servings,
                    keyword_init: true)
    # TODO remove redundancy
#     ATTRIBUTES = [:meal_type, :a_bit, :one_serving, :two_servings]
#     attr_accessor *ATTRIBUTES
  end
end
