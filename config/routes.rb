Rails.application.routes.draw do
  resources :tasks
  resources :task_schedules do
    member do
        put 'complete'
        patch 'complete'
    end
  end
  resources :users

  root to: 'users#index'
end
