class User < ApplicationRecord
    has_secure_password
    has_many :products, dependent: :nullify
    has_many :reviews, dependent: :nullify
    has_many :news_articles, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :liked_reviews, through: :like, source: :reviews

def full_name
    "#{first_name} #{last_name}".strip
end 

end
