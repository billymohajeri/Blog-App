Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:create, :new, :destroy, :index]
      resources :likes, only: [:create]
    end
  end 

  root 'users#index'
end

    # resources :posts, only: [:index, :show, :new, :create, :destroy] do
    #   member do
    #     post 'likes' => 'posts#likes', as: :likes
    #   end
    #   resources :comments, only: [:create, :new, :destroy, :index]
    # end
  