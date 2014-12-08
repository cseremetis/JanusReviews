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

    get '/ReviewTemplate' do
        erb(:ReviewTemplate)
    end

    post '/CreateReview' do

        DATABASE.add("Reviews", {:productName => params[:productName], :ratings => {:outstanding => 0, :above_average => 0, :average => 0, :below_average => 0, :poor => 0, :horrible => 0}})

        redirect('/ExistingReviews')
    end

    post '/UpdateReview' do
        erb(:ReviewTemplate)
    end 
end




