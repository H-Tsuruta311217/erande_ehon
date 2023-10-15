class RemoveMemberIdFromBooks < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :member_id, :integer
  end
end
