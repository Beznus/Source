class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.integer :company_id
      t.integer :product_id
      t.string :recipient
      t.string :sender
      t.string :from
      t.text :body
      t.text :body_plain
      t.text :body_html
      t.datetime :created_at
      t.datetime :updated_at
      t.string :subject

      t.timestamps null: false
    end
  end
end
