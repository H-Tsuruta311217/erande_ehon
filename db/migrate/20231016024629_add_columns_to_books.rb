class AddColumnsToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :isbn, :bigint
    add_column :books, :author, :string
    add_column :books, :url, :string
    add_column :books, :image_url, :string
  end
end
