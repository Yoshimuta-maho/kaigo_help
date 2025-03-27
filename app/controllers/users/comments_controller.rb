class Users::CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])  # 投稿を取得
    @post_comment = @post.comments.build(comment_params)
    @post_comment.user = current_user  # 現在のユーザーを設定

    if @post_comment.save
      redirect_to post_path(@post), notice: 'コメントが投稿されました'
    else
      # コメントが空など、保存できなかった場合にエラーメッセージを表示
      render 'users/posts/show', alert: 'コメントを入力してください'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
