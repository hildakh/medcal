Rails.application.routes.draw do
  get "medications/index"
  get "medications/show"
  get "medications/create"
  get "medications/update"
  get "medications/destroy"
  root "home#index"
end
