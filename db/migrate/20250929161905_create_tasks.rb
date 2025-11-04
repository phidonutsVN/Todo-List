class CreateTasks < ActiveRecord::Migration[8.0]
  def up
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.integer :status, default: 0, null: false
      t.datetime :due_date
      t.references :user, null: false, foreign_key: true
      t.references :category, foreign_key: true
      t.timestamps
    end
  end

  def down
    drop_table :tasks
  end
end
