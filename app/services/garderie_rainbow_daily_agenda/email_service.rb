class GarderieRainbowDailyAgenda  
  class EmailService
    include ActiveModel::Model
    
    attr_accessor :address, :port, :username, :password, :use_ssl, :from_email, :from_name
    
    validates :address, :port, :username, :password, :use_ssl, :from_email, :from_name, presence: true
    
    class << self
      def instance
        @instance ||= new.tap do |email_service|
          email_service.address = 'smtp.gmail.com'
          email_service.port = 587
          email_service.use_ssl = true
        end
      end
    end
    
    def domain
      address.split('.')[-2..-1].join('.')
    end
        
    def deliver!(mail)
      mail.delivery_method :smtp, address: address, port: port, domain: domain, user_name: username, password: password, enable_starttls_auto: use_ssl

      mail.deliver!
    end
    
  end
end
