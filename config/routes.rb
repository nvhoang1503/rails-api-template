Rails.application.routes.draw do
  namespace :admin do
    get 'admins/index'
  end

  namespace :admin do
    get 'admins/admins'
  end

  mount API::Root => '/'

  devise_for :users
  devise_for :admins

  root 'home#index'
  get 'home/index'
  get 'apidoc', to: "application#apidoc"


  
  namespace :admin do
    get 'home/index'
    root :to => "home#index"
    resources :admins do
    end
  end

end
