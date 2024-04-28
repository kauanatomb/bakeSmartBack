Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :categories
  resources :measurement_units
  resources :ingredients
  resources :recipes
  resources :recipe_ingredients

  root to: 'recipes#index'
end
