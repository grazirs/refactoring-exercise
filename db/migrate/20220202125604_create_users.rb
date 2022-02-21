class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false

      t.string :first_name, null: false
      t.string :last_name, null: false
      t.boolean :guest, null: false, default: false

      t.timestamps
    end

    add_index(:users, %i[email], unique: true)
  end
end
