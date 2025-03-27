class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    # if @user != current_user
    #   pp current_user
    #   redirect_to user_path(current_user) and return
    # end
    @posts = @user.posts
    @post = Post.new
    @joined_groups = @user.join_groups
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user), alert: '他のユーザーの情報は編集できません。'
      return
    end
  end

  def update
    @user = User.find(params[:id])
  
    # 他のユーザーの情報を更新しようとした場合、自分のマイページにリダイレクト
    unless @user == current_user
      redirect_to user_path(current_user), alert: '他のユーザーの情報は編集できません。'
      return
    end
  
    # パスワードが空の場合、パスワードの変更なしで更新
    if user_params[:password].blank? && user_params[:password_confirmation].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end
  
    if @user.update(user_params)
      sign_in(@user,bypass: true)
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
    if params[:id].present?
      if current_user.nil?
        redirect_to new_session_path, alert: 'ログインしてください'
      elsif current_user.id.to_s != params[:id]
        redirect_to user_path(current_user), alert: '他のユーザーのアカウントを操作することはできません。'
      end
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :image_icon, :password, :password_confirmation)
  end
end
