class Admin::SessionsController < Devise::SessionsController
  # Deviseの標準のログイン機能を使うため、このままで大丈夫です。
  
  def new
    super
  end

  def create
    super
  end

  def destroy
    super
  end

  protected

  # ログイン後に遷移するパス
  def after_sign_in_path_for(resource)
    admin_root_path  # 管理者ログイン後に管理画面トップへ遷移
  end

  # ログアウト後に遷移するパス
  def after_sign_out_path_for(resource)
    new_admin_session_path  # ログアウト後は管理者ログイン画面へ
  end
end
