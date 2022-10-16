# frozen_string_literal: true

Rails.application.routes.draw do
  root 'tests#index'

  get    'signup',  to: 'users#new'
  get    'login',   to: 'sessions#new'
  post   'login',   to: 'sessions#create'
  delete 'logout',  to: 'sessions#destroy'

  resources :users, except: :index

  resources :tests do
    resources :questions, shallow: true, except: :index do
      resources :answers, shallow: true, except: :index
    end

    member do
      post :start
    end
  end

  resources :tests_users, only: %i[show update] do
    member do
      get :result
      put :restart
    end
  end
end
