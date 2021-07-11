Rails.application.routes.draw do
  devise_for :users
  get 'tasks/calender' => 'tasks#calender'
  post 'tasks/create' => 'tasks#create'
  root to: 'tasks#index'

  resources :tasks
  post '/tasks/:id/done' => 'tasks#done',   as: 'done'
  resources :profiles, only: [:show, :new, :edit, :create, :update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
