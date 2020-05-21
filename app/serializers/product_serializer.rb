class ProductSerializer < ActiveModel::Serializer
  attributes( :id, :title, :description, :price,  :tag_names, :created_at, :updated_at)

  belongs_to :user, key: :seller
  has_many :reviews



  class ReviewSerializer < ActiveModel::Serializer
 

    attributes :id, :body, :rating, :liker_count
    belongs_to :user
    has_many :likers, through: :likes, source: :user

    def liker_count
      object.likers.count
    end
  
  end


end
