class Post < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :image_post
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true

  def likes_by?(user)
    liked_users.include?(user)
  end
  
end
