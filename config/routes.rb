Rails.application.routes.draw do
  resources :donations
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'static_pages#home'
  get 'static_pages/home'
  get 'static_pages/help'
  devise_scope :user do
    get 'drugstores/sign_up' => "users/registrations#drugstore_register_new"
    post 'drugstores/sign_up' => "users/registrations#drugstore_register_create"
  end
  devise_for :users,
    controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/jose_linkedin" => redirect("https://www.linkedin.com/in/jos%C3%A9-victor-ferreira-04058062/")
  get "/andre_linkedin" => redirect("https://www.linkedin.com/in/andr%C3%A9-vieira-dias-7a298154/")
end
