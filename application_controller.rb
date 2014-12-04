require 'bundler'
Bundler.require

require_relative './models/reviews.rb'

#created November 30, 2014 by Christian Seremetis and Daniel Greenberg

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

    get '/SpecificReview' do
        erb(:ReviewTemplate)
    end

    post '/CreateReview' do
        @review=Review.new(params[:productName])
        @review.name

        redirect('/ExistingReviews')
    end

    #post '/ViewReview' do
     #   $name = @review.name
    #end
end





