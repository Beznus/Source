class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :name
      t.integer :company_id
      t.string :email

      t.timestamps null: false
    end
  end
end
