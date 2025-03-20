class Users::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.new(post: @post)
    
    if @like.save
      redirect_to request.referer
    else
      # エラーハンドリング
      redirect_to request.referer, alert: 'いいねの登録に失敗しました。'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = current_user.likes.find_by(post: @post)
    
    if @like&.destroy
      redirect_to request.referer
    else
      # エラーハンドリング
      redirect_to request.referer, alert: 'いいねの削除に失敗しました。'
    end
  end
end

