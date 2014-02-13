class CreatePurchases < ActiveRecord::Migration
	def change
		create_table :purchases do |t|
      t.string :purchaser_name, :nil => false
      t.text :item_description, :nil => false
      t.float :item_price, :nil => false
      t.integer :purchase_count, :nil => false
      t.string :merchant_address, :nil => false
      t.string :merchant_name, :nil => false
      t.timestamps
    end
  end
end
