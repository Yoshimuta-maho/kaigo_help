class RemoveEmailAndResetPasswordTokenFromGenres < ActiveRecord::Migration[6.1]
  def change
    remove_index :genres, name: "index_genres_on_email"
    remove_index :genres, name: "index_genres_on_reset_password_token"
  end
end
