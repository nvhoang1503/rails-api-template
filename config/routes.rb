Rails.application.routes.draw do
  mount API::Root => '/'


  root 'home#index'
  get 'home/index'
  get 'apidoc', to: "application#apidoc"


  devise_for :users
  
  namespace :admin do
    get 'home/index'
    root :to => "home#index"
  end

end
