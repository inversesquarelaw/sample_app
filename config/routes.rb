SampleApp::Application.routes.draw do

  resources :users
  resources :sessions, :only => [:new, :create, :destroy]

  root :to => "pages#home"

  match '/contact',   to: 'pages#contact',	via: :all
  match '/about',     to: 'pages#about',	via: :all
  match '/help',      to: 'pages#help',		via: :all
  match '/signup',    to: 'users#new',		via: :all
  match '/signin',    to: 'sessions#new',	via: :all
  match '/signout',   to: 'sessions#destroy',	via: :all

end
