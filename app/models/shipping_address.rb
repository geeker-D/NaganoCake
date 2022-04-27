class ShippingAddress < ApplicationRecord
  belongs_to :customer

  validates :post_code, {length: {is: 7} }
  validates :address, :to_name, presence: true

  #引数にcurrent_customerを渡して[郵便番号＋住所＋氏名」, 会員ID]を配列で返却する
  scope :customer_relation, -> (current_customer) {where(customer_id: current_customer.id).map{ |sa| ["〒"+sa.post_code+" "+sa.address+" "+sa.to_name, sa.id]}}

end

