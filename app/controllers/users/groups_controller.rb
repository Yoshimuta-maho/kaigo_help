# app/controllers/users/groups_controller.rb

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

  # グループ作成
  def create
    @group = current_user.groups.build(group_params)  # ユーザーに紐づくグループを作成

    if @group.save
      redirect_to user_groups_path, notice: 'グループが作成されました。'
    else
      render :new
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)  # 名前と説明を許可
  end
end

