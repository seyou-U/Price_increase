class AddQuoteToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :quote, :text
  end
end
