Rails.application.routes.draw do
  # letter_opener メールチェック用ルート（開発環境専用）
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # devise用ルート（user認証関係）
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # トップページ
  root to: "home#home"

  # ダッシュボード
  get "dashboard", to: "dashboard#index"

  # habitsルート
  resources :habits, only: %i[ index new show edit create update destroy ] do
    resources :habit_checks, only: %i[ create destroy ] # habits_checksルート
  end
end
