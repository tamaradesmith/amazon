# Add the following validations to your Product model:
class Product < ApplicationRecord
has_many :reviews, dependent: :destroy
    # The title must be present
    # The title must be unique (case insensitive)

validates(:title, presence: true, uniqueness: { case_sensitive: false }) 

# The price must be a number that is more than 0

validates(:price, numericality: {
    greater_than: 0
})

# The description must be present
# The description must have at least 10 characters

validates(:description, presence: {message: "please add a messages"}, length: { minimum: 10 }
        )
        
        before_validation :set_default_view_count
        before_validation :capitalize_title


        private
# Add the following callbacks methods to your product model:

# A callback method to set the default price to 1

def set_default_view_count
    self.price ||=1
end

# A callback method to capitalize the product title before saving
def capitalize_title
    self.title = title.capitalize
end

end
