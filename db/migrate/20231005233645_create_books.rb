class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :member_id
      t.integer :category_id, null: false
      t.timestamps
    end
  end
end
