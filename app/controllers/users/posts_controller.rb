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

    def create
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      if @post.save
        redirect_to posts_path, notice: '投稿が作成されました。'
      else
        render :new
      end
    end

    def show
      @post = Post.find(params[:id])  # 指定されたIDの投稿を取得
    end

    def edit
      @post = Post.find(params[:id])
      redirect_to posts_path, alert: '編集権限がありません。' unless @post.user == current_user
    end

    def update
      @post = Post.find(params[:id])

      if @post.update(post_params)
        redirect_to post_path(@post), notice: '投稿が更新されました。'
      else
        render :edit
      end
    end


    private

    def post_params
      params.require(:post).permit(:title, :body)  # 投稿のタイトルと内容を許可
    end
  end
end
