require 'models/garderie_rainbow_daily_agenda/drink'
require 'models/garderie_rainbow_daily_agenda/meal'
require 'models/garderie_rainbow_daily_agenda/mood'
require 'models/garderie_rainbow_daily_agenda/potty_time'

class GarderieRainbowDailyAgenda
  class Child
    MEAL_TYPES = [:breakfast, :lunch, :pm_snack]
    attr_accessor :name, 
                  :nap_time_start, 
                  :nap_time_end,
                  :bring_diapers, 
                  :bring_extra_clothes, 
                  :bring_special_milk_or_formula, 
                  :bring_wipes, 
                  :bring_other,
                  :i_had_fun_when_we,
                  :special_notes,
                  :educator_name,
                  :email
    attr_writer :new_drink, :new_potty_time
    
    def nap_time_start_string
      return if nap_time_start.nil?
      Time.at(nap_time_start.time / 1000.0).strftime('%I:%M %p')      
    end    

    def nap_time_end_string
      return if nap_time_end.nil?
      Time.at(nap_time_end.time / 1000.0).strftime('%I:%M %p')      
    end        
    
    def meals
      @meals ||= MEAL_TYPES.reduce({}) {|hash, meal_type| hash.merge(meal_type => Meal.new(type: meal_type))}
    end
    
    def drinks
      @drinks ||= []
    end
    
    def new_drink
      @new_drink ||= Drink.new
    end
    
    def add_drink
      drinks << new_drink
      self.new_drink = Drink.new
    end
    
    def remove_drinks(drinks_to_remove)
      drinks.delete_if {|drink| drinks_to_remove.include?(drink)}
    end
    
    def potty_times
      @potty_times ||= []
    end
    
    def new_potty_time
      @new_potty_time ||= PottyTime.new
    end
    
    def add_potty_time
      potty_times << new_potty_time
      self.new_potty_time = PottyTime.new
    end
    
    def remove_potty_times(potty_times_to_remove)
      potty_times.delete_if {|potty_time| potty_times_to_remove.include?(potty_time)}
    end
    
    def mood
      @mood ||= Mood.new
    end
  end
end
