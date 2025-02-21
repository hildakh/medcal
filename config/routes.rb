Rails.application.routes.draw do
  get "prescription_items/create"
  get "prescriptions/create"
  resources :medications

  root "home#index"
end
