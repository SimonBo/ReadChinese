Rails.application.routes.draw do
  resources :test_answers

  resources :reading_tests

  resources :checked_words
  get 'checked_words/mark_as_checked/:checked_word' => "checked_words#mark_as_checked", as: 'mark_as_checked'
  get 'words/find/:word/:text' => 'words#find'
  resources :texts

  delete 'words/unfavorite_word/:id' => 'words#unfavorite_word', as: :unfavorite_word
  post 'words/favorite_word/:id' => 'words#favorite_word', as: :favorite_word
  get 'words/favorite_words' => 'words#favorite_words', as: :favorite_words

  devise_for :users
  resources :words

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'words#index'

  # Example of regular route:

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
