class RemoveEmailAndResetPasswordTokenFromLikes < ActiveRecord::Migration[6.1]
  def change
    remove_index :likes, name: "index_likes_on_email"
    remove_index :likes, name: "index_likes_on_reset_password_token"
  end
end
