class ChildReport < ApplicationRecord
  before_save :send_email
  
  def child
    RubySerial.load(child_object)
  end
  
  def send_email
    Rails.logger.info child.inspect
    self.email_sent_at = Time.now    
    true
  end
end
