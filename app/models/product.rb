class Product < ActiveRecord::Base
  has_many :quotes
  has_many :emails
end
