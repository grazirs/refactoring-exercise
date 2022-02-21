class CreateSales < ActiveRecord::Migration[6.1]
  def change
    create_table :sales do |t|
      t.string :name, null: false, index: true
      t.integer :unit_price_cents, null: false

      t.timestamps
    end
  end
end
