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
        
    def email_sender
      # note: gotta assign local vars first because of their bad DSL that evaluates blocks in a different context
      address_var = address
      domain_var = domain
      port_var = port
      username_var = username
      password_var = password
      use_ssl_var = use_ssl
      from_email_var = from_email
      from_name_var = from_name
      @email_sender = MailHandler.sender(:smtp) do |dispatcher|
        dispatcher.address = address_var
        dispatcher.port = port_var
        dispatcher.domain = domain_var
        dispatcher.username = username_var
        dispatcher.password = password_var
        dispatcher.use_ssl = use_ssl_var
      end
    end
    
  end
end
