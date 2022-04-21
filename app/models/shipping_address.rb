class ShippingAddress < ApplicationRecord
  belongs_to :customer
  
  validates :post_code, :address, :to_name, presence: true
  
end
