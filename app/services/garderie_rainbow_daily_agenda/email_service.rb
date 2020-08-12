class GarderieRainbowDailyAgenda  
  class EmailService
    include ActiveModel::Model
    
    ATTRIBUTES = [:address, :authentication, :port, :username, :password, :use_ssl, :from_email, :from_name]
    ATTRIBUTES_REQUIRED = ATTRIBUTES.reject {|a| a == :use_ssl}    
                
    attr_accessor *ATTRIBUTES
    
    validates *ATTRIBUTES_REQUIRED, presence: true
    validates :port, numericality: true
    validates :from_email, email: true
     
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
    
    def rsa
      @rsa ||= load_rsa
    end
    
    def rsa_private_key_file
      File.join('config', '.rsa')
    end
    
    def rsa_private_key
      File.read(rsa_private_key_file) if File.exist?(rsa_private_key_file)
    end
    
    def load_rsa
      private_key = rsa_private_key
      OpenSSL::PKey::RSA.new(private_key || 2048).tap do |loaded_rsa|
        if private_key.nil?
          FileUtils.mkdir_p(File.dirname(rsa_private_key_file))
          File.write(rsa_private_key_file, loaded_rsa.to_pem) if private_key.nil?
          FileUtils.chmod(0600, rsa_private_key_file)
        end
      end
    end
    
    def config_file
      @config_file ||= File.join('config', 'email_service.yml')
    end        
    
    def save      
      config_yaml = YAML.dump(attributes)
      FileUtils.mkdir_p(File.dirname(config_file))
      File.write(config_file, rsa.public_encrypt(config_yaml)) unless config_yaml.to_s.empty?
    end
    
    def load
      config_yaml = rsa.private_decrypt(File.read(config_file)) if File.exist?(config_file)
      self.attributes = YAML.load(config_yaml) unless config_yaml.to_s.empty?
    rescue => e
      # No Op. Ignore if rsa failed in decryption (someone deleted its key) or file was corrupted.
      # Just save a new one later on.
      Glimmer::Config.logger.error e.full_message
    end
  end
end
