Rails.application.routes.draw do
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
end