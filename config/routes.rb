Rails.application.routes.default_url_options[:host] = 'rorlab.org'

Rails.application.routes.draw do

  resources :glossary_definitions
  resources :glossaries
  root "welcome#index"
  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

  get 'tags', to: 'tags#list'
  get 'purchase_requests/confirm_request/:id' => 'purchase_requests#confirm_request_toggle', as: :confirm_purchase

  # Info routing
  get 'info/about', as: :about
  get 'info/howto', as: :howto
  get 'info/copyright', as: :copyright
  get 'info/security', as: :security
  get 'info/contributor', as: :contributors

  get 'podcasts/grap' => 'podcasts#grap'
  get 'events/upcoming'
  # Exception routing
  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#server_error'

  # Devise routing
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resource :user_profile

  # Resources routing
  resources :schedules do
    resources :appliers do
      member do
        put 'accept'
        put 'recommand'
      end
    end
  end

  concern :commentable do
    resources :comments
  end
  resources :favlinks, :codebanks, :rblogs, :events, :purchase_requests, :group_purchases, :courses, :lectures, :schedules, :glossaries, concerns: :commentable

  resources :courses do
    resources :lectures
  end

  resources :group_purchases do
    resources :purchase_requests
  end

  resources :plazas
  resources :bundlelinks do
    resources :favlinks
  end
  resources :favlinks
  resources :bulletins do
    resources :posts
  end
  resources :questions do
    resources :answers
  end

  resources :podcasts, only: [ :index, :show ], concerns: :commentable

  get 'weeklynews/index', as: 'weeklynews'
  get 'weeklynews/grap', as: 'weeklynews_grap'


  # API routing
  namespace :api do
    resources :questions do
      resources :answers
    end
  end

end
