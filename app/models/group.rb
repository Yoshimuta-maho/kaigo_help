class Group < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :group_users, dependent: :destroy
  belongs_to :user
end
