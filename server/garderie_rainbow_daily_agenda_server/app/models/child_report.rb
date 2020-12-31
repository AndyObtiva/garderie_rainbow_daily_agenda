class ChildReport < ApplicationRecord
  before_save :send_email
  
  def child
#     RubySerial.load(child_object)
    pd child_object
    pd JSON.load(child_object)
    YASL.load(child_object, whitelist_classes: [GarderieRainbowDailyAgenda::Child, GarderieRainbowDailyAgenda::Mood, GarderieRainbowDailyAgenda::Meal, GarderieRainbowDailyAgenda::Drink, GarderieRainbowDailyAgenda::PottyTime])
  end
  
  def send_email
    pd child.inspect
    begin
      @email_service = GarderieRainbowDailyAgenda::EmailService.instance
      email_message = GarderieRainbowDailyAgenda::EmailMessage.new(child)
      pd @email_service.deliver!(email_message.to_mail)
      pd self.email_sent_at = Time.now
      true
    rescue Exception => e
      pd e
      self.errors[:base] << e.message
      false
    end
  end
end
