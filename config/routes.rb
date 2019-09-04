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
end
