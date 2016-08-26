Rails.application.routes.draw do
  namespace :admin do
    get 'home/index'
  end

  root 'home#index'
  get 'home/index'

  namespace :admin do
    root :to => "home#index"
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'apidoc', to: "application#apidoc"
  
end
