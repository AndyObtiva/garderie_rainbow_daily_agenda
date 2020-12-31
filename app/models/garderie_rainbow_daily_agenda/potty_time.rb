class GarderieRainbowDailyAgenda
  class PottyTime < Struct.new(:change_time, :wet, :bm, :diaper, :toilet,
                                keyword_init: true)
#     include ActiveModel::Model
    include Glimmer

#     ATTRIBUTES = [ :change_time, :wet, :bm, :diaper, :toilet ]
#     attr_accessor :change_time_java, *ATTRIBUTES
#     rubyserial_only *ATTRIBUTES
        
#     validates :change_time, presence: true
    
    def initialize(*args)
      super
      [:change_time, :wet, :bm, :diaper, :toilet].each do |attribute|
        observe(self, attribute) do |new_value|
          notify_observers("#{attribute}_string")
        end
      end
    end
        
    def change_time_string
      change_time&.strftime('%I:%M %p')
    end
    
    def change_time
      Time.at(change_time_java.time / 1000.0) unless change_time_java.nil?
    end
    
    [:wet, :bm, :diaper, :toilet].each do |boolean_property|
      define_method("#{boolean_property}_string") do
        send(boolean_property) ? 'x' : ''
      end
    end
    
  end
  
end
