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
        @reviews=DATABASE.get_data
        erb(:ExistingReviews)
    end

    get '/ReviewTemplate' do
        erb(:ReviewTemplate)
    end

    get '/Error' do
        erb(:Error)
    end

    post '/CreateReview' do

        puts params[:rating]

        if params[:rating] == "a"
            DATABASE.add("Reviews", {:productName => params[:productName], :rating => {:a => 1, :b => 0, :c => 0, :d => 0, :e => 0, :f => 0}})
        elsif params[:rating] == "b"
            DATABASE.add("Reviews", {:productName => params[:productName], :rating => {:a => 0, :b => 1, :c => 0, :d => 0, :e => 0, :f => 0}})
        elsif params[:rating] == "c"
            DATABASE.add("Reviews", {:productName => params[:productName], :rating => {:a => 0, :b => 0, :c => 1, :d => 0, :e => 0, :f => 0}})
        elsif params[:rating] == "d"
            DATABASE.add("Reviews", {:productName => params[:productName], :rating => {:a => 0, :b => 0, :c => 0, :d => 1, :e => 0, :f => 0}})
        elsif params[:rating] == "e"
            DATABASE.add("Reviews", {:productName => params[:productName], :rating => {:a => 0, :b => 0, :c => 0, :d => 0, :e => 1, :f => 0}})
        else
            DATABASE.add("Reviews", {:productName => params[:productName], :rating => {:a => 0, :b => 0, :c => 0, :d => 0, :e => 0, :f => 1}})
        end
            
        redirect('/ExistingReviews')
    end
 
    post '/UpdateReview' do
        @reviews=DATABASE.get_data

        @reviews.each do |review|
            if (params[:name]).downcase == (review[1]["productName"]).downcase then

                @name = review[1]["productName"]
                @opinion = review[1]["rating"]
            end
        end

        erb(:ReviewTemplate)
    end 
end




