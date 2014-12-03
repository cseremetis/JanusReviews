#used as a template to add reviews to the website, each review is a new object

#this creates a class of reviews
class Review 

    attr_accessor :name

    ALL=[]
    OUTSTANDING = []
    ABOVE_AVERAGE = []
    AVERAGE = []
    BELOW_AVERAGE = []
    POOR = []
    HORRIBLE = []
    
    def initialize(name)
        @name = name
        ALL << self 
    end

    def self.all
        ALL
    end
end





