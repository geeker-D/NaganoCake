class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details
  has_many :items, through: :order_details

  enum payment_type: { credit_card: 0, transfer: 1 }
  enum status: { wait_deposit: 0, confirm_deposit: 1, making:2, prepare_shipping:3, complete_shipping:4 }

  validates :customer_id, :payment_type, :post_code, :address, :to_name, :shipping_fee, :total_payment,  presence: true
  validates :post_code, {length: {is: 7} }

  def with_tax_price
    (price_non_tax * 1.1).floor
  end

  def total_item_order
    total_payment - shipping_fee
  end
end
