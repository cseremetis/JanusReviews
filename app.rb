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
            if value.downcase.strip == a.productName.downcase.strip
                @existing = true
                @product = a
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

       #if the product doesn't exist, create a new object
       if @existing == false
            @product = Product.new
            @product.productName = params[:productName]
        end

        #set rating based on radio buttons 
        case params[:rating]

        when "a"
            @product.face1 += 1
        when "b"
            @product.face2 += 1
        when "c"
            @product.face3 += 1
        when "d"
            @product.face4 += 1
        when "e"
            @product.face5 += 1
        when "f"
            @product.face6 += 1    
        end
        @product.save   

        erb(:ReviewTemplate)

    end
 
    post '/UpdateReview' do
        check(params[:searchName])

        erb(:ReviewTemplate)
    end 

    post '/AddReview' do
        @product = @newProduct
        erb(:CreateReview)
    end

    post '/Defer' do 
        redirect('/CreateReview')
    end
end







