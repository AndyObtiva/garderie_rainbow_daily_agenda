class ChildReport < ApplicationRecord
  before_save :send_email
  
  def send_email
    
    true
  end
end
