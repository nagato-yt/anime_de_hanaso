Rails.application.routes.draw do
 
  root to: 'public/homes#top'
 
  namespace :public do
      resources :posts, only: [:index,:show,:create] do
          resources :post_comments, only: [:create, :destroy, :index, :show]
          resources :favorites, only: [:index]
           resource :favorites, only: [:create, :destroy]
           
      end
      
      resources :users do
          resource :relationships, only: [:create, :destroy]
          get 'followings' => 'relationships#followings', as: 'followings'
          get 'folloers' => 'relationships#followers', as: 'followers'
          
          member do
              get :favorites
          end
      end
      resources :chats, only: [:show, :create]
       get '/posts/hashtag/:name', to: "posts#hashtag"
  end
 # 顧客用
 devise_for :users,skip: [:passwords], controllers: {
   registrations: "public/registrations",
   sessions: 'public/sessions'
   
 }
 devise_scope :user do
     post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
 end 

 # 管理者用
 devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
   sessions: "admin/sessions"
 }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
