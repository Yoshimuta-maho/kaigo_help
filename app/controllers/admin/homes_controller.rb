class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    # ダッシュボードの内容をここで定義
    @total_users = User.count
    @total_groups = Group.count
  end
end
