class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  # enume定義
  enum payment_type: { credit_card: 0, transfer: 1 }
  enum product_status: { impossible_making: 0, wait_making: 1, making:2, complete:3 }
  
  

  #バリデーション
  validates :order_id, :item_id, :amount, :price,  presence: true

end
