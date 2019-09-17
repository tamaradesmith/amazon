class User < ApplicationRecord
    has_secure_password
    has_many :products, dependent: :nullify
    has_many :reviews, dependent: :nullify
    has_many :news_articles, dependent: :destroy

def full_name
    "#{first_name} #{last_name}".strip
end 

end
