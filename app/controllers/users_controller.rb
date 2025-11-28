class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user # 現在ログインしているユーザー情報取得
  end
end
