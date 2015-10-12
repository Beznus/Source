class Company < ActiveRecord::Base
  has_secure_token
  has_many :emails
 
  validates_uniqueness_of :token
 
  before_validation :generate_token
  
  def regenerate_token
    if self.token.blank?
      self.regenerate_token
    end
  end
end
