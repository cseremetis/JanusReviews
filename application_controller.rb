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
        @reviews = DATABASE.get_data
        erb(:ExistingReviews)
    end

    post '/CreateReview' do
        @ratings=[]
        @ratings.push(params[:rating])

        DATABASE.add("Reviews", {:productName => params[:productName], :rating => @ratings})

        redirect('/ExistingReviews')
    end
end





