require "net/http"
require "uri"
require "json"

class LineMessageSender
  LINE_API_URL = "https://api.line.me/v2/bot/message/push"

  def self.send_message(line_user_id, text)
    uri = URI.parse(LINE_API_URL)

    header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer #{ENV['LINE_CHANNEL_ACCESS_TOKEN']}"
    }

    body = {
      to: line_user_id,
      messages: [
        {
          type: "text",
          text: text
        }
      ]
    }

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = body.to_json

    http.request(request)
  end
end
