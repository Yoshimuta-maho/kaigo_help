class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :image_icon
  has_many :posts, dependent: :destroy
  belongs_to :group, optional: true
  belongs_to :group_user, optional: true

  def admin?
    self.admin
  end
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.slice(:name)
    if conditions[:name].present?
      where(conditions).first
    else
      super
    end
  end

end
