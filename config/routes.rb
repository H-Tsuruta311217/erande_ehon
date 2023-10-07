Rails.application.routes.draw do


  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :members,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }


  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about", as: "about"
    get "/search" => "searches#search"
    resources :members, only: [:update, :create, :show]
    get "/members" => "members#show"
    get "/members/information/edit" => "members#edit"
    get "/members/confirm" => "members#confirm"
    patch "/members/withdraw" => "members#withdraw"
    get '/categorysearches/search', to: 'categorysearches#search'
    resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update] do
      resource:favorites, only: [:index, :create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
  end

  namespace :admin do
    root to: 'homes#top', as: 'top'
    get 'search' => 'homes#search', as: 'search'
    resources :books
    resources :categories, only: [:index, :edit, :create, :update]
    resources :members, only: [:index, :show, :edit, :update]
  end




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
