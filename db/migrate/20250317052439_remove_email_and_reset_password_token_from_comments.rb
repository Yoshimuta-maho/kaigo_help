class RemoveEmailAndResetPasswordTokenFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_index :comments, name: "index_comments_on_email"
    remove_index :comments, name: "index_comments_on_reset_password_token"
  end
end
