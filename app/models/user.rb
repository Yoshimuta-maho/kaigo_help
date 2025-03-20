class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :image_icon
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  belongs_to :group, optional: true
  belongs_to :group_user, optional: true
  
  validates :name, presence: true

    def update_without_current_password(params, *options)
      params.delete(:current_password)
      if params[:password].blank? && params[:password_confirmation].blank?
        params.delete(:password)
        params.delete(:password_confirmation)
      end
      result = update(params, *options)
      clean_up_password
      result
    end

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
