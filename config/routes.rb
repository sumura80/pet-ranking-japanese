Rails.application.routes.draw do
  devise_for :users
  root 'categories#index'

  resources :posts do 
  	resources :comments
  end

 
  get 'categories/dogs' ,to: 'categories#dogs'
  get 'categories/cats' ,to: 'categories#cats'
  get 'categories/rabbits' ,to: 'categories#rabbits'



     # createアクションに対応するルーティングを追加
  post "likes/:post_id/create" => "likes#create"

   # destroyアクションに対応するルーティングを追加
  post "likes/:post_id/destroy" => "likes#destroy"



       # createアクションに対応するルーティングを追加
  post "votes/:comment_id/create" => "votes#create"

   # destroyアクションに対応するルーティングを追加
  post "votes/:comment_id/destroy" => "votes#destroy"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
