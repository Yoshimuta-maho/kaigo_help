class ChangeIsActiveToUser < ActiveRecord::Migration[6.1]
  def up
    change_column :users, :is_active, :boolean, null: false, default: true
  end

  def down
    change_column :users, :is_active, :boolean
  end
end
