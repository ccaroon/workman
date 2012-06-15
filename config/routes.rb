Workman::Application.routes.draw do
  resources :countdowns
  resources :lists
  resources :obstacles
  resources :goals
  resources :work_days
  resources :todos
  resources :entries
  resources :notes
  resources :users
  match '/:controller(/:action(/:id))'
end
