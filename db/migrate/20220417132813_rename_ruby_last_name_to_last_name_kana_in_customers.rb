class RenameRubyLastNameToLastNameKanaInCustomers < ActiveRecord::Migration[6.1]
  def change
    rename_column :customers, :ruby_last_name, :last_name_kana
    rename_column :customers, :ruby_first_name, :first_name_kana
    rename_column :customers, :delete_flg, :is_deleted
  end
end
