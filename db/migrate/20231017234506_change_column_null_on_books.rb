class ChangeColumnNullOnBooks < ActiveRecord::Migration[6.1]
  def change
    change_column_null :books, :item_caption, true
  end
end
