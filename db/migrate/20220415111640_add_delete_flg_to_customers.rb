class AddDeleteFlgToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :delete_flg, :boolean, default: false, null: false
    add_column :customers, :last_name, :string, null: false
    add_column :customers, :first_name, :string, null: false
    add_column :customers, :ruby_last_name, :string, null: false
    add_column :customers, :ruby_first_name, :string, null: false
    add_column :customers, :post_code, :string, null: false
    add_column :customers, :address, :text, null: false
    add_column :customers, :phone_number, :string, null: false
  end
end

