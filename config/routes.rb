Rails.application.routes.draw do
  get 'reviews/new'
  root 'welcome#home'
  
  controller :welcome do
    get :home
    get :about
    get :contact_us
    get :index
    
    post :thank_you
    get :bill_splitter
    post :bill_splitter
  end
  
  # get 'welcome/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/products/new', {to: 'products#new', as: :new_product}

  post '/products/new', {to: 'products#create', as: :products}

  get '/products/:id', {to: 'products#show', as: :product}

  get '/products', {to: 'products#index', as: :index_products}

  get '/products/:id/edit', {to: 'products#edit', as: :edit_product}

  patch '/products/:id', {to: 'products#update'}

  delete '/products/:id', { to: 'products#destroy'}

  resources :products do
    resources :reviews,  only:
      [:create, :destroy, :delete]
  end

    resources :users, only:[:new, :create]

    resources :sessions, only: [:new, :create] do
      delete :destroy, on: :collection
    end

    resources :news_articles, only: [:new, :create, :show, :destroy, :index, :edit, :update]
end
