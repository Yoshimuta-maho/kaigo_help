class Post < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :image_post
  has_many :likes, dependent: :destroy
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
  
end
