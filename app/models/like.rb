class Like < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :user
  belongs_to :post
  #belongs_to :comment
  validates :user_id, uniqueness: { scope: :post_id }
end
