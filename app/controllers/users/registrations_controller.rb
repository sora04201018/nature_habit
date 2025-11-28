# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  protected

  # 独自カラム[:name]も編集できるように、 strong parametersに追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end

  # パスワード無しでアカウント更新を可能にする
  def update_resource(resource, params)
    if params[:password].blank? && params[:password_confirmation].blank?
      # パスワードに関係ない更新（例：nameだけ変更）
      resource.update_without_password(params)
    else
      # パスワードを含む更新は通常の処理
      resource.update_with_password(params)
    end
  end

  # 更新後にリダイレクトするパス
  def after_update_path_for(resource)
    mypage_path   # マイページに戻したい場合（任意）
  end
end
