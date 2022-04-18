class CreateShippingAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :shipping_addresses do |t|
      t.integer :customer_id, null: false
      t.string :post_code, null: false
      t.string :address, null: false
      t.string :to_name, null: false

      t.timestamps
    end
  end
end
