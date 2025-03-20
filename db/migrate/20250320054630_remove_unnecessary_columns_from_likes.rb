class RemoveUnnecessaryColumnsFromLikes < ActiveRecord::Migration[6.1]
  def change
    remove_column :likes, :reset_password_token, :string
    remove_column :likes, :reset_password_sent_at, :datetime
    remove_column :likes, :remember_created_at, :datetime
  end
end
