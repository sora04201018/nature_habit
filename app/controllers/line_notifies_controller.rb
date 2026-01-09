class LineNotifiesController < ApplicationController
  before_action :authenticate_user!

  def create
    token = SecureRandom.hex(16) # ランダムな合言葉

    current_user.update!(line_notify_enabled: true, line_link_token: token)
    redirect_to line_add_friend_url(token), allow_other_host: true
  end

  private

  def line_add_friend_url(token)
    "https://line.me/R/ti/p/@381twjkh?linkToken=#{token}" # NatureHabit公式LINEリダイレクト先(トークン付き)
  end
end
