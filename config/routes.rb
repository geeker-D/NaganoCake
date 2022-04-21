Rails.application.routes.draw do

# ルーティングのカスタマイズ
# get 'URL' => 'コントローラ#アクション', as: 'prefixの名称'
# get 'books/index_simple' => 'books#index', as: 'books'

# 会員
  scope module: 'public' do
    root :to =>'homes#top'
    get "/about"=>'homes#about'

    devise_for :customers,skip: [:passwords]
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

    resources :shipping_addresses, only: [:index, :edit, :create, :update, :destroyy]

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

# 管理者のルーティング
    #         new_admin_session GET    /admin/sign_in(.:format)                                 admin/sessions#new
    #             admin_session POST   /admin/sign_in(.:format)                                 admin/sessions#create
    #     destroy_admin_session DELETE /admin/sign_out(.:format)                                admin/sessions#destroy
    #                 admin_root GET    /admin(.:format)                                         admin/homes#top
    #               admin_about GET    /admin/about(.:format)                                   admin/homes#about
    # index_order_admin_customer GET    /admin/customers/:id/index_order(.:format)               admin/customers#index_order
    #           admin_customers GET    /admin/customers(.:format)                               admin/customers#index
    #       edit_admin_customer GET    /admin/customers/:id/edit(.:format)                      admin/customers#edit
    #             admin_customer GET    /admin/customers/:id(.:format)                           admin/customers#show
    #                           PATCH  /admin/customers/:id(.:format)                           admin/customers#update
    #                           PUT    /admin/customers/:id(.:format)                           admin/customers#update
    #               admin_genres GET    /admin/genres(.:format)                                  admin/genres#index
    #                           POST   /admin/genres(.:format)                                  admin/genres#create
    #           edit_admin_genre GET    /admin/genres/:id/edit(.:format)                         admin/genres#edit
    #               admin_genre PATCH  /admin/genres/:id(.:format)                              admin/genres#update
    #                           PUT    /admin/genres/:id(.:format)                              admin/genres#update
    #               admin_items GET    /admin/items(.:format)                                   admin/items#index
    #                           POST   /admin/items(.:format)                                   admin/items#create
    #             new_admin_item GET    /admin/items/new(.:format)                               admin/items#new
    #           edit_admin_item GET    /admin/items/:id/edit(.:format)                          admin/items#edit
    #                 admin_item GET    /admin/items/:id(.:format)                               admin/items#show
    #                           PATCH  /admin/items/:id(.:format)                               admin/items#update
    #                           PUT    /admin/items/:id(.:format)                               admin/items#update
    #   admin_order_order_detail PATCH  /admin/orders/:order_id/order_details/:id(.:format)      admin/order_details#update
    #                           PUT    /admin/orders/:order_id/order_details/:id(.:format)      admin/order_details#update
    #               admin_order GET    /admin/orders/:id(.:format)                              admin/orders#show
    #                           PATCH  /admin/orders/:id(.:format)                              admin/orders#update
    #                           PUT    /admin/orders/:id(.:format)                              admin/orders#update
    # search_item_admin_searches GET    /admin/searches/search_item(.:format)                    admin/searches#search_item

# 会員用のルーティング
  #                         root GET    /                                          public/homes#top
  #                       about GET    /about(.:format)                           public/homes#about
  #         new_customer_session GET    /customers/sign_in(.:format)               public/sessions#new
  #             customer_session POST   /customers/sign_in(.:format)               public/sessions#create
  #     destroy_customer_session DELETE /customers/sign_out(.:format)              public/sessions#destroy
  # cancel_customer_registration GET    /customers/cancel(.:format)                public/registrations#cancel
  #   new_customer_registration GET    /customers/sign_up(.:format)               public/registrations#new
  #   edit_customer_registration GET    /customers/edit(.:format)                  public/registrations#edit
  #       customer_registration PATCH  /customers(.:format)                       public/registrations#update
  #                             PUT    /customers(.:format)                       public/registrations#update
  #                             DELETE /customers(.:format)                       public/registrations#destroy
  #                             POST   /customers(.:format)                       public/registrations#create
  #             customers_mypage GET    /customers/mypage(.:format)                public/customers#show
  #         unsubscribe_customer PATCH  /customers/:id/unsubscribe(.:format)       public/customers#unsubscribe
  #           defection_customer PATCH  /customers/:id/defection(.:format)         public/customers#defection
  #               edit_customer GET    /customers/:id/edit(.:format)              public/customers#edit
  #                     customer PATCH  /customers/:id(.:format)                   public/customers#update
  #                             PUT    /customers/:id(.:format)                   public/customers#update
  #       destroy_all_cart_items DELETE /cart_items/destroy_all(.:format)          public/cart_items#destroy_all
  #                   cart_items GET    /cart_items(.:format)                      public/cart_items#index
  #                             POST   /cart_items(.:format)                      public/cart_items#create
  #                   cart_item PATCH  /cart_items/:id(.:format)                  public/cart_items#update
  #                             PUT    /cart_items/:id(.:format)                  public/cart_items#update
  #                             DELETE /cart_items/:id(.:format)                  public/cart_items#destroy
  #                       items GET    /items(.:format)                           public/items#index
  #                         item GET    /items/:id(.:format)                       public/items#show
  #     order_preconfirm_orders POST   /orders/order_preconfirm(.:format)         public/orders#order_preconfirm
  #             complete_orders GET    /orders/complete(.:format)                 public/orders#complete
  #                       orders GET    /orders(.:format)                          public/orders#index
  #                             POST   /orders(.:format)                          public/orders#create
  #                   new_order GET    /orders/new(.:format)                      public/orders#new
  #                       order GET    /orders/:id(.:format)                      public/orders#show
  #           shipping_addresses GET    /shipping_addresses(.:format)              public/shipping_addresses#index
  #                             POST   /shipping_addresses(.:format)              public/shipping_addresses#create
  #       edit_shipping_address GET    /shipping_addresses/:id/edit(.:format)     public/shipping_addresses#edit
  #             shipping_address PATCH  /shipping_addresses/:id(.:format)          public/shipping_addresses#update
  #                             PUT    /shipping_addresses/:id(.:format)          public/shipping_addresses#update
  #         search_item_searches GET    /searches/search_item(.:format)            public/searches#search_item
  #       search_genre_searches GET    /searches/search_genre(.:format)           public/searches#search_genre