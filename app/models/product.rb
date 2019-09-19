# Add the following validations to your Product model:
class Product < ApplicationRecord

    has_many :reviews, dependent: :destroy
    belongs_to :user
    # The title must be present
    # The title must be unique (case insensitive)

    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings

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

    def tag_names
        self.tags.map{ |t| t.name}.join(", ")
    end

    def tag_names=(rhs)
        self.tags = rhs.strip.split(/\s*,\s*/).map do |tag_names|
            Tag.find_or_initialize_by(name: tag_names)
        end
    end
       


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
