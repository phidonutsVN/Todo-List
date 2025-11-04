class CreateCategories < ActiveRecord::Migration[8.0]
  def up
    create_table :categories do |t|
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end

  def down
    drop_table :categories
  end
end
