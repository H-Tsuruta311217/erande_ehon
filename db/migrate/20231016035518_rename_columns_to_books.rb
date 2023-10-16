class RenameColumnsToBooks < ActiveRecord::Migration[6.1]
  def change
    rename_column :books, :name, :title
    rename_column :books, :description, :item_caption
  end
end
