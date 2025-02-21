Rails.application.routes.draw do
  resources :medications
  resources :prescriptions do
     resources :prescription_items
  end

  resources :medications do
    get :calculate_cost, on: :collection
  end

  root "home#index"
end
