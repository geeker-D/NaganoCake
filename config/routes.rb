Rails.application.routes.draw do

# 会員
  scope module: 'public' do
    root :to =>'homes#top'
    get "/about"=>'homes#about'

    devise_for :customers,skip: [:passwords], controllers: { registrations: 'public/registrations'}
    get "customers/mypage"=>'customers#show'
    resources :customers, only: [:edit, :update] do
      get :unsubscribe, on: :member
      patch :defection, on: :member
    end
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      delete :destroy_all, on: :collection
    end
    resources :items, only: [:index, :show]
    resources :orders, only: [:index, :show, :new, :create] do
      post :order_preconfirm, on: :collection
      get :complete, on: :collection
    end

    resources :shipping_addresses, only: [:index, :edit, :create, :update, :destroy]

    resources :searches, only: [:search_item, :search_genre] do
      get :search_item, on: :collection
      get :search_genre, on: :collection
    end
  end


  # 管理者
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    root :to =>'homes#top'
    get "/about"=>'homes#about'

    resources :customers, only: [:index, :show, :edit, :update] do
      get :index_order, on: :member
    end
    resources :genres, only: [:index, :edit, :create, :update]
    resources :items, only: [:index, :show, :new, :edit, :create, :update]
    resources :orders, only: [:show, :update] do
      resources :order_details, only: [:update]
    end
    resources :searches, only: [:search_item] do
       get :search_item, on: :collection
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end