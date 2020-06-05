Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy,:show]
  resources :users
  # お気に入りの保存と削除するためのルーティング
  resources :favorites, only: [:new, :show, :index, :create, :destroy ]
  resources :contacts, only: [:new, :create,]
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  resources :posts do
    collection do
      post :confirm
    end
  end
end
