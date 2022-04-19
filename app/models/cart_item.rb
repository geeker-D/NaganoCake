class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item
  
  
  def total_payment_no_shipfee
    
  end

end
