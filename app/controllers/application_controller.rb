class ApplicationController < ActionController::Base
  helper_method :current_customer, :admin_signed_in?
  before_action :hide_customer_name_for_admin


  private

  def hide_customer_name_for_admin
      @hide_customer_name = request.path.start_with?('/admin')
  end
end
