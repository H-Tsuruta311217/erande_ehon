class RemoveStatusFromPostComment < ActiveRecord::Migration[6.1]
  def change
    remove_column :post_comments, :status, :integer
  end
end
