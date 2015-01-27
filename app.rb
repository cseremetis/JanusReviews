#created January 27, 2015 by Christian Seremetis
require "bundler"
Bundler.require


require_relative './models/product.rb'
require_relative './models/review.rb'

set :database, "sqlite3:product.db"
class MyApp < Sinatra::Base

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
        #a page used to display all the reviews for a certain product
        erb(:ReviewTemplate)
    end

    post '/CreateReview' do
        #where the user can add a review
        #reviews are made using input that is received in a textbox
        #the user can review any product, historical figure, concept, service, etc.
        #once their review is submitted, the user will be redirected to the ReviewTemplate page

        @every = []
        #creates an array of all products
        @every = Product.all

        #checks to see if the product already exists
        @every.each do |a|
            if params[:productName] == a.productName
                #updates the original product review
            else
                @product = Product.new
                @product.productName = params[:productName]

                #assigns face values based on which radio button is selected
                case params[:rating]
                when "a"
                    @product.face1 = 1
                    @product.face2 = 0
                    @product.face3 = 0
                    @product.face4 = 0
                    @product.face5 = 0
                    @product.face6 = 0

                when "b"
                    @product.face1 = 0
                    @product.face2 = 1
                    @product.face3 = 0
                    @product.face4 = 0
                    @product.face5 = 0
                    @product.face6 = 0
            
                when "c"
                    @product.face1 = 0
                    @product.face2 = 0
                    @product.face3 = 1
                    @product.face4 = 0
                    @product.face5 = 0
                    @product.face6 = 0
            
                when "d"
                    @product.face1 = 0
                    @product.face2 = 0
                    @product.face3 = 0
                    @product.face4 = 1
                    @product.face5 = 0
                    @product.face6 = 0
                
                when "e"
                    @product.face1 = 0
                    @product.face2 = 0
                    @product.face3 = 0
                    @product.face4 = 0
                    @product.face5 = 1
                    @product.face6 = 0

                when "f"
                    @product.face1 = 0
                    @product.face2 = 0
                    @product.face3 = 0
                    @product.face4 = 0
                    @product.face5 = 0
                    @product.face6 = 1
                end
                @product.save 
            end
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







