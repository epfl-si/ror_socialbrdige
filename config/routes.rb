 Rails.application.routes.draw do

  scope(:path => '/socialbridge') do
    devise_for :users
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

    get '/auth/:provider/callback', to: 'sources#create_or_update_from_oauth'
    get '/auth/failure', to: redirect('/')
    resources :users, only: [:index, :show]
    resources :sources do
      resources :requests, only: [:new, :create]
    end
    resources :requests, only: [:show, :edit, :update, :destroy] do
      get 'refresh', on: :member
    end

    get '/query/:token', to: 'requests#query', as: "request_query"
    root to: 'sources#index'
  end
  root to: 'sources#index'
end
