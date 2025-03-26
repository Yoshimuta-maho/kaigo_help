class Users::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :edit, :update, :destroy, :chat, :leave]
  before_action :check_owner, only: [:edit, :update, :destroy]  

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
    @joined_users = @group.join_users
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

  def chat
    # チャットページを表示
    @group = Group.find_by(id: params[:id])
    
    # @group が存在しない場合はエラーメッセージを表示
    if @group.nil?
      flash[:alert] = "グループが見つかりません"
      redirect_to root_path and return
    end
    
    @messages = @group.messages.order(created_at: :asc)
    @message = @group.messages.new
  end
  
  def leave
    # ユーザーがそのグループに参加しているか確認
    if @group.join_users.include?(current_user)
      # グループユーザーの関連を削除して脱退
      @group.join_users.delete(current_user)
      flash[:notice] = "グループから脱退しました。"
    else
      flash[:alert] = "このグループには参加していません。"
    end
    redirect_to groups_path
  end
end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:group_name, :genre_id, :group_icon)  # グループ名、ジャンル、アイコンを許可
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
  def check_owner
    unless @group.user == current_user  # オーナー以外はアクセス不可
      redirect_to @group, alert: "You are not the owner of this group."
    end
  end