Rails.application.routes.draw do
  resources :medications

  root "home#index"
end
