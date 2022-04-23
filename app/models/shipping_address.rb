class ShippingAddress < ApplicationRecord
  belongs_to :customer

  validates :post_code, {length: {is: 7} }
  validates :address, :to_name, presence: true

  scope :customer_relation, -> (current_customer) {where(customer_id: current_customer.id).map{ |sa| ["〒"+sa.post_code+" "+sa.address+" "+sa.to_name, sa.id]}}

end
