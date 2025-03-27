class Group < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :group_icon
  belongs_to :user # グループのオーナー
  has_many :group_users, dependent: :destroy
  has_many :join_users, through: :group_users, source: :user
  has_many :messages, dependent: :destroy
end
