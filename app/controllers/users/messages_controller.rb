class Users::MessagesController < ApplicationController
  before_action :set_group

  def create
    @message = @group.messages.new(message_params)
    @message.user = current_user  # メッセージのユーザーを現在のユーザーに設定

    if @message.save
      # メッセージが保存された場合の処理
      redirect_to chat_group_path(@group)  # チャットページにリダイレクト
    else
      # メッセージが保存されなかった場合の処理
      render 'chat'
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])  # グループIDを取得してグループをセット
  end

  def message_params
    params.require(:message).permit(:content)  # メッセージのcontentパラメータを許可
  end
end
