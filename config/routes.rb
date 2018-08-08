Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'dashboard#index'
  # devise_for :users

  resources :employees do
    member do
      post :retrieve_from_blockchain
    end

    collection do
      post :blockchain_employee_search
    end
  end

  resources :organizations do
    member do
      post :retrieve_from_blockchain
    end
  end

  resources :users do
    member do
      get :set_role
      post :save_role
    end
  end

  resources :employee_experiences do
    member do
      get :approval
      get :rejection
      post :approve
      post :reject
    end

    collection do
      post :blockchain_experience_search
    end
  end

  resources :posts

  namespace :api do
    namespace :v1 do
      resources :posts do
        collection do
          post :blockchain_data
        end
      end
    end
  end
end
