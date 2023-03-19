Rails.application.routes.draw do
    root to: 'public/homes#top'
   
    
  namespace :public do
      resources :posts do
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
          # 退会機能
          get 'users/:id/unsubscribe' =>'users#unsubscribe', as: 'unsubscribe'
          patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
          
      end
      resources :chats, only: [:show, :create]
      resources :groups do
       get "join" => "groups#join"
       delete "all_destroy" => "groups#all_destroy"
       resources :group_messages, only: [:index, :create]
      end
  end
  
  namespace :admin do
   root to: 'homes#top'
   
    resources :tags, only: [:index, :create, :edit, :update]
    resources :users, only: [:index,:show,:destroy] do
     # 退会機能
      get 'users/:id/unsubscribe' =>'users#unsubscribe', as: 'unsubscribe'
      patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
    end
    resources :posts, only: [:index,:show, :destroy] do 
     resources :post_comments, only: [:index,:show, :destroy]
    end
    resources :groups, only: [:index,:show, :destroy] do
       get "join" => "groups#join"
       delete "all_destroy" => "groups#all_destroy"
        resources :group_messages, only: [:index, :create]
    end
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
