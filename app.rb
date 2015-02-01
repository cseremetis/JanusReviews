#created January 27, 2015 by Christian Seremetis
require "bundler"
Bundler.require


require_relative './models/product.rb'
require_relative './models/review.rb'

set :database, "sqlite3:product.db"
class MyApp < Sinatra::Base
    #this method is used to check for preexisting reviews
    def check(value)
        @existing = false
        every = []
        every = Product.all

        #iterates through all existing products to see if the given 
        #product name already exists
        every.each do |a|
            if value.downcase.strip == a.name.downcase.strip
                @existing = true
                @original = a
            end
        end
    end

    get '/' do
        #brings user to the home page
        erb :index
    end

    get '/CreateReview' do
        #brings user to the "create review" page
        erb(:CreateReview) 
    end

    get '/ExistingReviews' do
        #allows the user to view all existing reviewed products
        @reviews=Product.all
        erb(:ExistingReviews)
    end

    get '/ReviewTemplate' do
        #this is a page used to display all the reviews for a certain product
        erb(:ReviewTemplate)
    end

    post '/CreateReview' do
        #where the user can add a review
        #reviews are made using input that is received in a textbox
        #the user can review any product, historical figure, concept, service, etc.
        #once their review is submitted, the user will be redirected to the ReviewTemplate page


        #checks to see if the product already exists
       check(params[:productName])

       if @existing == true
            #adjusts original
        else
            #creates new
        end
        
        redirect('/ExistingReviews')
    end
 
    post '/UpdateReview' do
        erb(:ReviewTemplate)
    end 

    post '/AddReview' do
        redirect('/CreateReview')
    end

    post '/Defer' do 
        redirect('/CreateReview')
    end
end







