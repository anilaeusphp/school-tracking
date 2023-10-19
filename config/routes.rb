Rails.application.routes.draw do
  devise_for :users, controllers: {confirmations: 'confirmations', omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :users, only: [:index, :show, :destroy, :edit, :update] do
    member do
      patch :ban # ban_user PATCH  /users/:id/ban(.:format)    users#ban
      patch :resend_confirmation_instructions
      patch :resend_invitation
    end
  end
  get 'landing_page', to: "static_pages#landing_page"
  get 'privacy_policy', to: "static_pages#privacy_policy"
  root "static_pages#landing_page"
end
