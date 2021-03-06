Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  resources :tasks
  resources :task_schedules do
    member do
        put 'complete'
        patch 'complete'
    end
  end
  resources :users do
    member do
        get 'today'
    end
  end

  root to: 'users#index'

end
