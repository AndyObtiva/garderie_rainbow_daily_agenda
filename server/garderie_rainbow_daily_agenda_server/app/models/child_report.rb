class ChildReport < ApplicationRecord
  before_save :send_email
  
  def child
    RubySerial.load(child_object)
  end
  
  def send_email
    Rails.logger.info child.inspect
    begin
      @email_service = GarderieRainbowDailyAgenda::EmailService.instance
      email_message = GarderieRainbowDailyAgenda::EmailMessage.new(child)
      @email_service.deliver!(email_message.to_mail)
      self.email_sent_at = Time.now    
      true
    rescue Exception => e
      Rails.logger.error e.full_message
      self.errors[:base] << e.message
      false
    end    
  end
end
