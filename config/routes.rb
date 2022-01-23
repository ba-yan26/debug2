Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users
  root :to =>"homes#top"
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]


  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get :followings, on: :member
    # あるユーザーがフォローしている人全員を表示するためのルーティング
    get :followers, on: :member
    # あるユーザーフォローしてくれている人（フォロワー）全員を表示するための
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end