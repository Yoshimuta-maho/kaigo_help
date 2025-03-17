module Users
  class PostsController < ApplicationController
    before_action :authenticate_user!

    # 投稿一覧
    def index
      @posts = Post.all.order(created_at: :desc)  # 投稿を新しい順に取得
    end

    # 新規投稿画面
    def new
      @post = Post.new
    end

    # 投稿作成
    def create
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      if @post.save
        redirect_to posts_path, notice: '投稿が作成されました。'
      else
        render :new
      end
    end

    private

    def post_params
      params.require(:post).permit(:title, :body)  # 投稿のタイトルと内容を許可
    end
  end
end
