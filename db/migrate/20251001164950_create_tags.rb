class CreateTags < ActiveRecord::Migration[8.0]
  def up
    create_table :tags do |t|
      t.string :name, null: false
      t.references :task, null: false, foreign_key: true
      t.timestamps
    end
  end
  def down
    drop_table :tags
  end
end
