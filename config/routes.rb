Rails.application.routes.draw do
  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#server_error'  

  root "welcome#index"
  devise_for :users
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

  namespace :api do
    resources :questions do
      resources :answers
    end
  end

  # resources :tasks, only: [ :index, :show, :create, :update, :destroy ]
  # scope :api do
  #   devise_for :users,
  #              :path_names => {
  #                sign_in: 'login',
  #                sign_out: 'logout'
  #              },
  #              :controllers => { :sessions => "users/sessions",
  #                                :registrations => "users/registrations",
  #                                :confirmations => "users/confirmations" }
  #   resources :users, except: [ :new, :edit ]

  #   resources :questions, only: [ :index, :show, :create, :update, :destroy ] do
  #     resources :answers, only: [ :index, :show, :create, :update, :destroy ]
  #   end
  # end

  # concern :commentable do
  #   resources :comments, only: [ :index, :show, :create, :update, :destroy ]
  # end

  # resources :posts, only: [ :index, :show, :create, :update, :destroy ], concerns: :commentable
  # match 'posts' => 'posts#options', via: :options

end
