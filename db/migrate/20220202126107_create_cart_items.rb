class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.references :cart, index: true, null: false
      t.references :sale, index: true, null: false

      t.integer :quantity, null: false, default: 1

      t.timestamps
    end
  end
end
