# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  def create
    # name と password を使ってユーザーを検索
    self.resource = User.find_by(name: params[:user][:name])

    # name が見つかった場合、パスワードを照合してサインイン
    if self.resource && self.resource.valid_password?(params[:user][:password])
      sign_in(resource_name, self.resource)
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      flash[:alert] = '名前かパスワードが間違っています。'
      render :new
    end
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
  
  def after_sign_in_path_for(resource)
    user_path  # ユーザーログイン後にユーザー専用トップへ遷移
  end

  def after_sign_out_path_for(resource)
    new_user_session_path  # ログアウト後はログイン画面へ
  end
  private

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :password])
  end
end
