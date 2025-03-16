class ApplicationController < ActionController::Base
  helper_method :current_user, :admin_signed_in?
  before_action :hide_user_name_for_admin


  private

  def hide_user_name_for_admin
      @hide_user_name = request.path.start_with?('/admin')
  end
end
