class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details
  has_many :items, through: :order_details

  # enume定義
  enum payment_type: { credit_card: 0, transfer: 1 }
  enum status: { wait_deposit: 0, confirm_deposit: 1, making:2, prepare_shipping:3, complete_shipping:4 }
end
