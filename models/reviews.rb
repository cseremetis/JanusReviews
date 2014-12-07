#used as a template to add reviews to the website, each review is a new object

#this creates a class of reviews
class Review 

    attr_accessor :name

    ALL=[]
    
    def initialize(name)
        @name = name
        ALL << self 
    end

    def self.all
        ALL
    end
end





#this is a comment