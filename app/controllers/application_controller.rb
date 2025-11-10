class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end

  # ログアウト後の遷移先を指定
  def after_sign_out_path_for(resource_or_scope)
    root_path # 今後ダッシュボードに遷移予定
  end

  # ログイン後の遷移先を指定
  def after_sign_in_path_for(resource_or_scope)
    root_path # 今後ダッシュボードに遷移予定
  end
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
