class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to @user, notice: 'プロフィールが更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @user = current_user
    if @user.destroy
      sign_out current_user  # 退会後にサインアウト
      redirect_to root_path, notice: 'アカウントが削除されました。'
    else
      redirect_to @user, alert: 'アカウントの削除に失敗しました。'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image_icon)
  end
end
