class RemoveEmailAndResetPasswordTokenFromGroupUsers < ActiveRecord::Migration[6.1]
  def change
    remove_index :group_users, name: "index_group_users_on_email"
    remove_index :group_users, name: "index_group_users_on_reset_password_token"
  end
end
