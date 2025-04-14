Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "main#about"

  get "blog" => "main#blog"
  get "connect" => "main#connect"
  get "post/:slug" => "main#post", as: :post
  get "search_posts" => "main#search_posts"

  namespace :admin do
    constraints(lambda { |req|
      req.user_agent !~ /\b(bot|crawler|spider)\b/i
    }) do
      root to: "posts#index"
      resources :posts
      resources :tags, only: [ :index, :create, :destroy ]
      resources :collections
    end
  end
end
