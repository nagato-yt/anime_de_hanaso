Rails.application.routes.draw do
    root to: 'public/homes#top'
    
  namespace :public do
   get 'warning' => 'homes#warning', as: 'warning'
      resources :posts, except: [:edit] do
          resources :post_comments, only: [:create, :destroy]
           resource :favorites, only: [:create, :destroy]
           
           #検索
           collection do
             get 'search'
           end
      end
      
      resources :users do
         #フォロー機能
          post 'follow' => 'relationships#follow',as: 'follow'
          delete 'unfollow' => 'relationships#unfollow', as: 'unfollow'
          get 'followings' => 'relationships#followings', as: 'followings'
          get 'folloers' => 'relationships#followers', as: 'followers'
          
          member do
              get :favorites
          end
          # 退会機能
          get 'users/:id/unsubscribe' =>'users#unsubscribe', as: 'unsubscribe'
          patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
          
          # 検索
          collection do
            get 'search'
          end
      end
      resources :chats, only: [:show, :create]
      resources :groups, except: [:new] do
       get "join" => "groups#join"
       delete "all_destroy" => "groups#all_destroy"
       resources :group_messages, only: [:index, :create]
       
       collection do
         get 'search'
       end
      end
  end
  
  namespace :admin do
   root to: 'homes#top'
   
    resources :tags, only: [:index, :create, :edit, :update] do
     collection do
      get 'search'
     end
    end
    resources :users, only: [:index,:show,:destroy] do
     # 退会機能
      get 'users/:id/unsubscribe' =>'users#unsubscribe', as: 'unsubscribe'
      patch '/users/:id/withdrawal' => 'users#withdrawal', as: 'withdrawal'
      
      collection do
        get 'search'
      end
    end
    resources :posts, only: [:index,:show, :destroy] do 
     resources :post_comments, only: [:index,:show, :destroy]
     collection do
      get 'search'
     end
    end
    resources :groups, only: [:index,:show, :destroy] do
       get "join" => "groups#join"
       delete "all_destroy" => "groups#all_destroy"
        resources :group_messages, only: [:index, :create]
        
        collection do
          get 'search'
        end
    end
  end
  
  
  
 #devise 
 # ユーザー用
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
