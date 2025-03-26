class Users::GroupsController < ApplicationController
  before_action :authenticate_user!

  # グループ一覧
  def index
    @groups = Group.all  # グループをすべて取得
  end

  # 新規グループ作成フォーム
  def new
    @group = Group.new
  end

  def show
    @group = Group.find(params[:id])  # IDからグループを取得
  end

  # グループ作成
  def create
    @group = current_user.groups.build(group_params)  # ユーザーに紐づくグループを作成

    if @group.save
      redirect_to groups_path, notice: 'グループが作成されました。'
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: 'グループが更新されました。'
    else
      render :edit, alert: '更新に失敗しました。'
    end
  end

  def destroy
    @group = Group.find(params[:id]) # 指定されたグループを取得
    @group.destroy # グループを削除
  
    redirect_to groups_path, notice: 'グループが削除されました。'
  end
  
  def join
    @group = Group.find(params[:id])
    if @group.join_users.include?(current_user)
      redirect_to @group, notice: '既に参加しています'
    else
      @group.join_users << current_user
      redirect_to @group, notice: 'グループに参加しました'
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:group_name, :genre_id, :group_icon)  # グループ名、ジャンル、アイコンを許可
  end
end
