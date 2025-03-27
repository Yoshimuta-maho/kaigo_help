class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    if current_admin.nil?
      redirect_to new_admin_session_path, alert: 'ログインが必要です'
    else
      @group = Group.new(group_params)
      @group.user_id = current_admin.id
      if @group.save
        redirect_to admin_groups_path, notice: 'グループを作成しました'
      else
        render :new
      end
    end
  end


  def edit
    @group = Group.find(params[:id])
  end

  def update
    if @group.update(group_params)
      redirect_to admin_group_path(@group), notice: 'グループ情報が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to admin_groups_path, notice: 'グループが削除されました。'
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:group_name, :group_icon)
  end

end
