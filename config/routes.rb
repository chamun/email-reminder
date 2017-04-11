Rails.application.routes.draw do
  devise_for :users

  authenticated(:user) { root "reminders#new" }

  unauthenticated do
    devise_scope(:user) { root "devise/sessions#new" }
  end

  resources :reminders, only: [:new, :create]
end
