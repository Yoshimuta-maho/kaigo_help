class ApplicationController < ActionController::Base
  helper_method :current_user, :admin_signed_in?
  before_action :hide_user_name_for_admin

  def admin_signed_in?
    current_user && current_user.admin?  # ユーザーが管理者なら true を返す
  end

  before_action :hide_user_name_for_admin

  def after_sign_in_path_for(resource)
    about_path
  end
  
  def after_sign_in_path_for(resource)
    about_path
  end

  def after_sign_out_path_for(resource)
    about_path
  end

  private

  def hide_user_name_for_admin
      @hide_user_name = request.path.start_with?('/admin')
  end
end
