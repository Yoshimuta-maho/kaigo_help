class ApplicationController < ActionController::Base
  helper_method :current_user, :admin_signed_in?
  before_action :hide_user_name_for_admin
  #before_action :authenticate_user!
  before_action :authenticate_admin!, if: -> { params[:controller].include?('admin') }

  def admin_signed_in?
    current_user && current_user.admin?  # ユーザーが管理者なら true を返す
  end

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    # Rails.logger.debug "Redirecting to: #{user_path(resource)}"
    user_path(resource)  # ログイン後に自分の詳細ページにリダイレクト
  end
  
  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource)
    about_path  # ログアウト後に「about」ページにリダイレクト
  end

  private

  def hide_user_name_for_admin
    @hide_user_name = request.path.start_with?('/admin')
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
