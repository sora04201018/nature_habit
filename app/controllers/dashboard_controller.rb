class DashboardController < ApplicationController
  # ログインしていない人を弾いて、ログイン画面に飛ばす
  before_action :authenticate_user!

  def index; end
end
