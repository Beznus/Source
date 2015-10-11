class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.integer :unit_price
      t.integer :minimum_order_quantity
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
