require 'bundler'
Bundler.require

require_relative './models/reviews.rb'

class MyApp < Sinatra::Base
    get '/about' do
        erb :index
    end

    get '/CreateReview' do
        erb(:CreateReview) 
    end

    get '/ExistingReviews' do
        @allProducts=Review.all
        erb(:ExistingReviews)
    end

    post '/CreateReview' do
        @review=Review.new(params[:productName])
        @review.name
        redirect('/ExistingReviews')
    end
end





