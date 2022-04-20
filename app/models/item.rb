class Item < ApplicationRecord

  has_many :cart_items
  has_many :order_details
  belongs_to :genre

  has_one_attached :image

  def get_image(width, height)
    image.variant(resize_to_limit: [width, height]).processed
  end

  def with_tax_price
    (price * 1.1).floor
  end

  #國原定義
  def get_item_image
    (image.attached?) ? image : 'no_image.jpg'
  end

end
