Rails.application.routes.draw do
  devise_for :users, controllers: {confirmations: 'confirmations'}

  resources :users, only: [:index, :show]
  get 'landing_page', to: "static_pages#landing_page"
  get 'privacy_policy', to: "static_pages#privacy_policy"
  root "static_pages#landing_page"
end
