class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genre_id, null: false
      t.string :name, null: false
      t.text :summary, null: false
      t.integer :price_non_tax, null: false
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
  end
end
