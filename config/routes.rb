Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :exchange_logs, only: [:create]
    end
  end

  resource :rates, only: [:index] do
    get :month, on: :collection
    get :day, on: :collection
    get :hour, on: :collection
  end
  root to: 'rates#index'
end
