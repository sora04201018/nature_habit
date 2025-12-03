class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user # ユーザー情報取得
  end
end
