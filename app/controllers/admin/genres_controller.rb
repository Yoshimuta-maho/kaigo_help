class Admin::GenresController < ApplicationController

  def new
    @genre = Genre.new
  end
  
  def index
    @genres = Genre.all
  end

  def create
    if current_admin.nil?
      redirect_to new_admin_session_path, alert: 'ログインが必要です'
    else
      @genre  = Genre.new(genre_params)
      if @genre.save
        redirect_to admin_genres_path, notice: 'ジャンルを作成しました'
      else
        render :new
      end
    end
  end

  def show
    @genre = Genre.find(params[:id])
  end

  def edit
    @genre = Genre.find(params[:id])

  end

  def update
    if @genre.update(genre_params)
      redirect_to admin_genre_path(@genre), notice: 'ジャンル情報が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to admin_genres_path, notice: 'ジャンルが削除されました'

  end

  private

  def genre_params
    params.require(:genre).permit(:genre_name)
  end
end
