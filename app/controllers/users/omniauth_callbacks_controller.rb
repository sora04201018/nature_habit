# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    callback("Google")
  end

  # def line
  # callback("LINE")
  # end

  private

  def callback(kind)
    auth = request.env["omniauth.auth"]
    @user = User.from_omniauth(auth)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
    else
      redirect_to new_user_registration_path, alert: "#{kind}ログインに失敗しました"
    end
  end
end
