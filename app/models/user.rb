class User < ApplicationRecord
    has_secure_password
    has_many :products, dependent: :nullify
    has_many :reviews, dependent: :nullify

end
