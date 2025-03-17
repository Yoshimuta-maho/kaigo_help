class RemoveEmailAndResetPasswordTokenFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_index :posts, name: "index_posts_on_email"
    remove_index :posts, name: "index_posts_on_reset_password_token"
  end
end
