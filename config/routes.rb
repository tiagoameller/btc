Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :exchange_logs, only: [:create]
    end
  end
  root to: 'welcome#index'
end
