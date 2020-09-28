require 'models/garderie_rainbow_daily_agenda/drink'
require 'models/garderie_rainbow_daily_agenda/meal'
require 'models/garderie_rainbow_daily_agenda/mood'
require 'models/garderie_rainbow_daily_agenda/potty_time'

class GarderieRainbowDailyAgenda
  class Child
    include ActiveModel::Model
  
    MEAL_TYPES = [:breakfast, :lunch, :pm_snack]
    ATTRIBUTES = [
      :name, 
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
      :email,
      :new_drink, 
      :new_potty_time,
      :meals,
      :mood
    ]
    attr_accessor :nap_time_start_java, :nap_time_end_java, *ATTRIBUTES
    rubyserial_only *ATTRIBUTES
    attr_writer :new_drink, :new_potty_time
    
    validates :name, presence: true
    validates :educator_name, presence: true
    validates :email, presence: true, email: true
    
    def nap_time_start_string
      nap_time_start&.strftime('%I:%M %p')      
    end
    
    def nap_time_start
      Time.at(nap_time_start_java.time / 1000.0) unless nap_time_start_java.nil?
    end    

    def nap_time_end_string
      nap_time_end&.strftime('%I:%M %p')      
    end        
    
    def nap_time_end
      Time.at(nap_time_end_java.time / 1000.0) unless nap_time_end_java.nil?
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
