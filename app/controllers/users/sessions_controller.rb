class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  def create
    if params[:user].present? # params[:user] が nil でないことを確認
      self.resource = User.find_by(email: params[:user][:email])
  
      if self.resource && self.resource.valid_password?(params[:user][:password])
        sign_in(resource_name, self.resource)
        respond_with resource, location: after_sign_in_path_for(resource)
      else
        flash[:alert] = 'メールアドレスかパスワードが間違っています。'
        render :new
      end
    else
      flash[:alert] = 'フォームの送信に失敗しました。'
      render :new
    end
  end
  
  protected
  
  def after_sign_in_path_for(resource)
    user_path(resource) # ユーザーログイン後にユーザー専用トップへ遷移
  end

  private

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end
end
