# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

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
    users_root_path  # ユーザーログイン後にユーザー専用トップへ遷移
  end

  def after_sign_out_path_for(resource)
    new_user_session_path  # ログアウト後はログイン画面へ
  end
end
