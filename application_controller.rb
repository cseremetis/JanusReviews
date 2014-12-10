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

    post '/CreateReview' do

        puts params[:rating]

        if params[:rating] == "outstanding"
            DATABASE.add("Reviews", {:productName => params[:productName], :rating => {:outstanding => 1, :above_average => 0, :average => 0, :below_average => 0, :poor => 0, :horrible => 0}})
        elsif params[:rating] == "above_average"
            DATABASE.add("Reviews", {:productName => params[:productName], :rating => {:outstanding => 0, :above_average => 1, :average => 0, :below_average => 0, :poor => 0, :horrible => 0}})
        elsif params[:rating] == "average"
            DATABASE.add("Reviews", {:productName => params[:productName], :rating => {:outstanding => 0, :above_average => 0, :average => 1, :below_average => 0, :poor => 0, :horrible => 0}})
        elsif params[:rating] == "below_average"
            DATABASE.add("Reviews", {:productName => params[:productName], :rating => {:outstanding => 0, :above_average => 0, :average => 0, :below_average => 1, :poor => 0, :horrible => 0}})
        elsif params[:rating] == "poor"
            DATABASE.add("Reviews", {:productName => params[:productName], :rating => {:outstanding => 0, :above_average => 0, :average => 0, :below_average => 0, :poor => 1, :horrible => 0}})
        else
            DATABASE.add("Reviews", {:productName => params[:productName], :rating => {:outstanding => 0, :above_average => 0, :average => 0, :below_average => 0, :poor => 0, :horrible => 1}})
        end
            
        redirect('/ExistingReviews')
    end
 
    post '/UpdateReview' do
        @reviews=DATABASE.get_data

        @reviews.each do |review|
            if params[:name] == review[1]["productName"] then
                @name = review[1]["productName"]
                #@opinions = review[2][:rating]
            end
        end
        erb(:ReviewTemplate)
    end 
end




