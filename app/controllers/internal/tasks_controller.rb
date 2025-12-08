class Internal::TasksController < ApplicationController
  # 外部から呼ぶので CSRF チェックを切る
  skip_before_action :verify_authenticity_token

  before_action :authenticate_api!

  def badge_assign
    User.find_each do |user|
      BadgeAwarder.new(user).call
    end

    render json: { status: "ok" }
  end

  private

  # 超簡単なAPIトークン認証
  def authenticate_api!
    token = request.headers["Authorization"]
    unless token == "Bearer #{ENV['TASK_API_TOKEN']}"
      render json: { error: "unauthorized" }, status: 401
    end
  end
end
