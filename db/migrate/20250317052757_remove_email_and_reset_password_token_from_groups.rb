class RemoveEmailAndResetPasswordTokenFromGroups < ActiveRecord::Migration[6.1]
  def change
    remove_index :groups, name: "index_groups_on_email"
    remove_index :groups, name: "index_groups_on_reset_password_token"
  end
end
