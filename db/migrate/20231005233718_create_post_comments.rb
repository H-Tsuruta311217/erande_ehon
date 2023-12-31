class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|
      t.text :comment
      t.integer :member_id
      t.integer :book_id
      t.integer :status, default: 0, null: false
      t.timestamps
    end
  end
end
