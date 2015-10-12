class Product < ActiveRecord::Base
  has_many :quotes
  has_many :emails
  belongs_to :company
  has_secure_token
  validates_uniqueness_of :token, scope: :company_id
 
  before_validation :generate_token
  
  def generate_token
    if self.token.blank?
      self.regenerate_token
    end
  end
end
