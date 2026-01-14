class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.order(created_at: :desc).limit(5)
  end

  def show
    notification = current_user.notifications.find(params[:id])
    # 既読処理
    notification.update!(read_at: Time.current) if notification.read_at.nil?

    redirect_to notification.redirect_path # モデル定義したredirect_pathメソッドで遷移先分岐
  end
end
