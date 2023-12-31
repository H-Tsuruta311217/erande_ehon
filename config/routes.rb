Rails.application.routes.draw do


  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # 顧客用
  # URL /members/sign_in ...
  devise_for :members,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :member do
    post 'members/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end


  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about", as: "about"
    get "/search" => "searches#search"
    resources :members, only: [:show, :edit, :update] do
      member do
        get :favorites
      end
      get "members/:id/favorites" => "members#favorite"
    end
    # 退会確認画面
    get "/members/:id/confirm" => "members#confirm", as: "confirm_member"
    # 論理削除用のルーティング
    patch "/members/:id/withdraw" => "members#withdraw", as: "withdraw_member"
    get '/category_search', to: 'tagsearches#category_search', as: 'category_search'
    resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update] do
      resources :post_comments, only: [:create, :destroy]
      resource:favorites, only: [:index, :create, :destroy]
    end
  end

  namespace :admin do
    root to: 'homes#top', as: 'top'
    get 'search' => 'homes#search', as: 'search'
    resources :books do
      resources :post_comments, only: [:create, :destroy]
      get 'books/search'
      collection do
        get :confirm
      end
    end
    resources :categories, only: [:index, :edit, :create, :update, :destroy]
    resources :members, only: [:index, :show, :edit, :update]
  end




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
