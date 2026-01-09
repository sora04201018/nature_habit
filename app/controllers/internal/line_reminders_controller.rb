class Internal::LineRemindersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_internal!

  def create
    LineReminderSender.call
    head :ok
  end

  private

  def authenticate_internal!
    token = request.headers["X-INTERNAL-TOKEN"]
    unless token == ENV["INTERNAL_API_TOKEN"]
      head :unauthorized
    end
  end
end
