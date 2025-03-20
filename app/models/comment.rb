class Comment < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :likes, dependent: :destroy
  belongs_to :user
  belongs_to :post

  validates :comment, presence: { message: "コメントは必須です" }
end
