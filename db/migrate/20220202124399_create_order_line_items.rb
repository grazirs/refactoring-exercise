class CreateOrderLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_line_items do |t|
      t.references :order, index: true, null: false
      t.references :sale, index: true, null: false

      t.integer :unit_price_cents, null: false
      t.integer :shipping_costs_cents, null: false, default: 0
      t.integer :discounts_cents, null: false, default: 0
      t.integer :taxes_cents, null: false, default: 0
      t.integer :paid_price_cents, null: false

      t.timestamps
    end
  end
end
