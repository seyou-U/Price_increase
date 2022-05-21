class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.integer :genre_id
      t.string :name
      t.integer :high_price
      t.text :explanation
      t.string :image

      t.timestamps
    end
  end
end
