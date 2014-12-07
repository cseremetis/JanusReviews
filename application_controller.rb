require 'bundler'
require 'firebase'
require_relative './models/firebase.rb'


#created November 30, 2014 by Christian Seremetis and Daniel Greenberg

DATABASE = FlatironBase.new("https://scorching-heat-1628.firebaseio.com")

class MyApp < Sinatra::Base
    get '/about' do
        erb :index
    end

    get '/CreateReview' do
        erb(:CreateReview) 
    end

    get '/ExistingReviews' do
        DATABASE.get_data
        erb(:ExistingReviews)
    end

    get '/SpecificReview' do
        erb(:ReviewTemplate)
    end

    post '/CreateReview' do
        @review=Review.new(params[:productName])
        DATABASE.add("Reviews", {:productName => params[:productName], :rating => params[:rating]})
        
        puts DATABASE.print_data
       

        redirect('/ExistingReviews')
    end

    #post '/ViewReview' do
     #   $name = @review.name
    #end
end





