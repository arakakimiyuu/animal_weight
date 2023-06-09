class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :customer_id, null: false
      t.integer :pet_id, null: false
      t.date :date, null: false
      t.string :weight, null: false
      t.string :feed, null: false
      t.string :amount_food, null: false
      t.timestamps
    end
  end
end
