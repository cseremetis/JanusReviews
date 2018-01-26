class ProductsController < ApplicationController
	def index
		products = Product.where(visible: true).shuffle
		if products.length >= 6
			@featured1 = products[0...3]
			@featured2 = products[3...6]
		end
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.new(name: params[:product][:name].downcase, description: params[:product][:description].downcase)
		@rating = params[:product][:ratings].to_i
		@product.ratings[@rating] += 1
		if @product.save
			render 'show'
		else
			flash[:error] = "Could not add product. Make sure that all fields have been filled out"
			render 'new'
		end
	end

	def show
		if !params[:id].nil?
			fetch
		else 
			@product = Product.find_by(name: params[:searchReviews][:review].downcase.strip)
		end
	end

	#lists all reviews
	def reviews
		@products = Product.where(visible: true)
	end

	def editDescription
		fetch
	end

	def addRating
		fetch
	end

	def report
		fetch
		@product.visible = false
		@product.save
		flash[:notice] = "The selected product has been reported as inappropriate"
		redirect_to '/reviews'
	end

	def update
		@product = Product.find(params[:id])
		if params[:product][:description]
			@product.description = params[:product][:description]
		end
		
		if params[:product][:ratings]
			@new_rating = params[:product][:ratings].to_i
			@product.ratings[@new_rating-1] += 1
		end

		if @product.save
			render 'show'
		else
			flash[:error] = "Could not update product. Make sure that all fields have been filled out"
			render 'show'
		end
	end

	def destroy
	end

	private

		def fetch
			@product = Product.find(params[:id])
		end
end