Rails.application.routes.draw do
  resources :medications
  resources :prescriptions do
    resources :prescription_items
  end

  resources :prescription_items do
    collection do
      get :calculate
    end
  end

  root "home#index"
end
