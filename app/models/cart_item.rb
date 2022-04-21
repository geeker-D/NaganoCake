class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item

  validates :amount, numericality: {greater_than: 0,less_than: 11}

  def self.total_payment_no_shipfee(cart_items)
    total_payment_no_shipfee = 0

    cart_items.each do |cart_item|
      total_payment_no_shipfee += (cart_item.item.price_non_tax * 1.1).floor * cart_item.amount
    end
    return total_payment_no_shipfee
  end

end
