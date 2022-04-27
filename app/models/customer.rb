class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shipping_addresses, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :items,through: :cart_items

  validates :first_name, :last_name, :first_name_kana, :last_name_kana, :post_code, :address, :phone_number, :email, presence: true
  validates :post_code, {length: {is: 7} }
  validates :phone_number, length: { minimum: 10, maximum: 11 }

  enum is_deleted: { 有効: false, 退会: true }


end
