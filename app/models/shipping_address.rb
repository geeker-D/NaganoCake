class ShippingAddress < ApplicationRecord
  belongs_to :customer
  
  validates :post_code, {length: {is: 7} }
  validates :address, :to_name, presence: true
  
end
