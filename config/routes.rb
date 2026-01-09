Rails.application.routes.draw do
  # letter_opener メールチェック用ルート（開発環境専用）
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  # devise用ルート（user認証関係）
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks" # SNS認証
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # 通知表示ルート
  resources :notifications, only: %i[ index show ]

  # webhook(LINE)用ルート line_webhookコントローラーのcallbackメソッド実行。
  post "/line/webhook", to: "line_webhooks#callback"

  # LINE通知ルート
  resource :line_notify, only: %i[ create ]

  # マイページ用ルート
  get "mypage", to: "users#show"

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

  # カレンダー
  get "calendar", to: "calendar#index"

  # habitsルート
  resources :habits, only: %i[ index new show edit create update destroy ] do
    resources :habit_checks, only: %i[ create destroy ] # habits_checksルート
    resources :comments, only: %i[ create destroy ] # habits用commentsルート
    resource :like, only: %i[ create destroy ] # habits用likesルート
  end

  # 習慣公開ルート（みんなの習慣）
  get "public_habit", to: "habits#public_index", as: :public_habit

  # postsルート
  resources :posts, only: %i[ index show new edit update create destroy ] do
    resources :comments, only: %i[ create destroy ] # posts用commentsルート
    resource :like, only: %i[ create destroy ] # posts用likesルート
  end

  # rails側でカテゴリー一覧をJSONで返すためのルート（tagify使用しているため）
  resources :categories, only: %i[ index ]

  # Github Actionsでバッジ付与のタスクを自動で反映させるためのルート（Github Actionsで処理を叩かせる）
  # internal_badge_assign_path
  namespace :internal do
    post "badge_assign", to: "tasks#badge_assign"
  end
end
