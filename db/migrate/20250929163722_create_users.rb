class CreateUsers < ActiveRecord::Migration[8.0]
  def up
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :encrypted_password, null: false
      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
