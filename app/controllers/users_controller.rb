class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = current_user # ここで現在のユーザーを直接設定
  end

  def update
    @user = current_user # ここでも現在のユーザーを取得
    if user_params[:password].blank? && user_params[:password_confirmation].blank?
      # パスワードが空の場合、パスワードの変更なしで更新
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end
  
    if @user.update(user_params)
      redirect_to @user, notice: 'プロフィールが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @user = current_user # ここでも現在のユーザーを取得
    if @user.destroy
      sign_out current_user 
      redirect_to root_path, notice: 'アカウントが削除されました。'
    else
      redirect_to @user, alert: 'アカウントの削除に失敗しました。'
    end
  end

  private

  def correct_user
    if current_user != User.find(params[:id]) # 現在のユーザーとIDが一致しない場合リダイレクト
      redirect_to root_path, alert: '他のユーザーのアカウントを操作することはできません。'
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :image_icon)
  end
end
