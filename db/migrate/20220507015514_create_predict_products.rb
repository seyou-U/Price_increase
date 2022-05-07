class CreatePredictProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :predict_products do |t|
      t.integer :user_id
      t.string :name
      t.text :explanation
      t.text :reason
      t.integer :image

      t.timestamps
    end
  end
end
