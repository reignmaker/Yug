Yug::Application.routes.draw do
  namespace :admin do
    resources :subjects do
      get :autocomplete_subject_title, :on => :collection
    end
  end
  ActiveAdmin.routes(self)
  root :to => 'stories#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  resources :shows
  #resources :images#, :only => [:index, :create, :destroy]
  resources :users
  resources :stories, :only => [:index, :show]
  resources(:subjects, :only => [:index, :show]) do
    get :autocomplete_subject_title, :on => :collection
  end
  
end
