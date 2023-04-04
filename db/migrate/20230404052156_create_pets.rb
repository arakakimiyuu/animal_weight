class CreatePets < ActiveRecord::Migration[6.1]
  def change
    create_table :pets do |t|
      t.integer :customer_id, null: false
      t.string :pet_name, null: false
      t.string :pet_type, null: false
      t.string :pet_kind, null: false
      t.boolean :gender,default: false , null: false
      t.string :color, null: false
      t.text :personality, null: false
      t.timestamps
    end
  end
end
