class LineWebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def callback
    events = params["events"]

    events.each do |event|
      next unless event["type"] == "follow"

      line_user_id = event["source"]["userId"]
      link_token = event["linkToken"]

      user = User.find_by(line_link_token: link_token)
      next unless user

      user.update!(
        line_user_id: line_user_id,
        line_link_token: nil
      )
    end

    head :ok
  end
end
