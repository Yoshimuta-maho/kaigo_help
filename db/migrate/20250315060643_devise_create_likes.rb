# frozen_string_literal: true

class DeviseCreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      ## Database authenticatable
      t.integer :user_id
      t.integer :post_id
      # t.string :email,              null: false, default: ""
      # t.string :encrypted_password, null: false, default: ""

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    # add_index :likes, :email,                unique: true
    # add_index :likes, :reset_password_token, unique: true
    # add_index :likes, :confirmation_token,   unique: true
    # add_index :likes, :unlock_token,         unique: true
  end
end
