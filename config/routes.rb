Rails.application.routes.draw do
  root to: 'public/homes#top'
  
  namespace :public do
      resources :posts do
          resource :favorites, only: [:create, :destroy]
      end
      resources :favorites, only: [:index]
      resources :users do
          member do
              get :favorites
          end
      end
      
  end
 # 顧客用
 devise_for :users,skip: [:passwords], controllers: {
   registrations: "public/registrations",
   sessions: 'public/sessions'
   
 }
 devise_scope :users do
     post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
 end 

 # 管理者用
 devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
   sessions: "admin/sessions"
 }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
