Rails.application.routes.draw do
  resources :products

  root 'products#index'
  
  #views/products/allReviews
  get '/reviews' => 'products#reviews'

  post '/search' => 'products#show'
  get '/report' => 'products#report'
  get '/editDescription' => 'products#editDescription'
  get '/addRating' => 'products#addRating'
end
