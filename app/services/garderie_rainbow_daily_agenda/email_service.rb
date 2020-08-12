class GarderieRainbowDailyAgenda  
  class EmailService
    include ActiveModel::Model
    
    ATTRIBUTES = [:address, :authentication, :port, :username, :password, :use_ssl, :from_email, :from_name]
    ATTRIBUTES_REQUIRED = ATTRIBUTES.reject {|a| a == :use_ssl}    
                
    attr_accessor *ATTRIBUTES
    
    validates *ATTRIBUTES_REQUIRED, presence: true
    
     
    class << self
      def instance
        @instance ||= new
      end
    end
    
    def initialize
      set_defaults
      load
    end
    
    def set_defaults
      self.address = 'smtp.office365.com'
      self.authentication = 'login'
      self.port = 587
      self.use_ssl = true
      self.username = 'garderierainbow@hotmail.com'
      self.password = nil
      self.from_email = 'garderierainbow@hotmail.com'
      self.from_name = 'Garderie Rainbow'    
    end
    
    def reset
      initialize
    end
    
    def domain
      @domain.nil? ? address.split('.')[-2..-1].join('.') : @domain
    end
        
    def deliver!(mail)
      mail.delivery_method :smtp, address: address, port: port, domain: domain, user_name: username, password: password, authentication: authentication, enable_starttls_auto: use_ssl

      mail.deliver!
    end
    
    def attributes
      ATTRIBUTES.reduce({}) do |hash, attribute|
        hash.merge(attribute => send(attribute))
      end
    end
    
    def config_file
      @config_file ||= File.join(GarderieRainbowDailyAgenda::APP_ROOT, 'config', 'email_service.yml')
    end
    
    def save
      config_yaml = YAML.dump(attributes)
      File.write(config_file, config_yaml) unless config_yaml.to_s.empty?
    end
    
    def load
      config_yaml = File.read(config_file) if File.exist?(config_file)
      self.attributes = YAML.load(config_yaml) unless config_yaml.to_s.empty?
    end
  end
end
