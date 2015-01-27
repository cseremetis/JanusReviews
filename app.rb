require 'bundler'
require 'firebase'
require_relative './models/firebase.rb'
require 'sinatra'


#created November 30, 2014 by Christian Seremetis and Daniel Greenberg

DATABASE = FlatironBase.new("https://scorching-heat-1628.firebaseio.com")

class MyApp < Sinatra::Base

    get '/' do
        erb :index
    end

    get '/about' do
        erb :About 
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

        @reviews = DATABASE.get_data
        @name = params[:productName]

        @reviews.each do |review|
            if @name.downcase.strip == (review[1]["productName"]).downcase.strip
                @object1 = review[1]["rating"]
            end
        end


        #creates the first map based on which radio button the user selected
        case params[:rating]

        when "a"
            DATABASE.add("Reviews", {:productName => params[:productName], :rating => {:a => 1, :b => 0, :c => 0, :d => 0, :e => 0, :f => 0}})
            @object2 = {:a => 1, :b => 0, :c => 0, :d => 0, :e => 0, :f => 0}
        when "b"
            DATABASE.add("Reviews", {:productName => params[:productName], :rating => {:a => 0, :b => 1, :c => 0, :d => 0, :e => 0, :f => 0}})
            @object2 = {:a => 0, :b => 1, :c => 0, :d => 0, :e => 0, :f => 0}
        when "c"
            DATABASE.add("Reviews", {:productName => params[:productName], :rating => {:a => 0, :b => 0, :c => 1, :d => 0, :e => 0, :f => 0}})
            @object2 = {:a => 0, :b => 0, :c => 1, :d => 0, :e => 0, :f => 0}
        when "d"
            DATABASE.add("Reviews", {:productName => params[:productName], :rating => {:a => 0, :b => 0, :c => 0, :d => 1, :e => 0, :f => 0}})
            @object2 = {:a => 0, :b => 0, :c => 0, :d => 1, :e => 0, :f => 0}
        when "e"
            DATABASE.add("Reviews", {:productName => params[:productName], :rating => {:a => 0, :b => 0, :c => 0, :d => 0, :e => 1, :f => 0}})
            @object2 = {:a => 0, :b => 0, :c => 0, :d => 0, :e => 1, :f => 0}
        when "f"
            DATABASE.add("Reviews", {:productName => params[:productName], :rating => {:a => 0, :b => 0, :c => 0, :d => 0, :e => 0, :f => 1}})
            @object2 = {:a => 0, :b => 0, :c => 0, :d => 0, :e => 0, :f => 1}
        end

        #creates a new hash made up of the values of the two previous hashes added together

        if @object1 == nil 
            @NewReview = @object2
        else
            a1 = @object1["a"]
            a2 = @object2[:a]
            b1 = @object1["b"]
            b2 = @object2[:b]
            c1 = @object1["c"]
            c2 = @object2[:c]
            d1 = @object1["d"]
            d2 = @object2[:d]
            e1 = @object1["e"]
            e2 = @object2[:e]
            f1 = @object1["f"]
            f2 = @object2[:f]

            @NewReview = {:a => a1.to_i + a2.to_i, :b => b1.to_i + b2.to_i, :c => c1.to_i + c2.to_i, :d => d1.to_i + d2.to_i, :e => e1.to_i + e2.to_i, :f => f1.to_i + f2.to_i}

            reviews = DATABASE.get_data

            reviews.each do |a|
                if @name.downcase.strip == (a[1]["productName"]).downcase.strip  
                    puts a[0]
                    id = a[0]
                    DATABASE.remove_by_id(id)
                end
            end 
                
            DATABASE.add("Reviews", {:productName => @name, :rating => @NewReview})
        end

        redirect('/ExistingReviews')
    end
 
    post '/UpdateReview' do
        @reviews=DATABASE.get_data

        @reviews.each do |review|
            if (params[:name]).downcase.strip == (review[1]["productName"]).downcase.strip 

                @name = review[1]["productName"]
                @NewReview = review[1]["rating"]
            end
        end

        erb(:ReviewTemplate)
    end 

    post '/AddReview' do
        redirect('/CreateReview')
    end

    post '/Defer' do 
        redirect('/CreateReview')
    end
end







