Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy,:show]
  resources :users
  resources :posts do
    collection do
      post :confirm
    end
  end
end
