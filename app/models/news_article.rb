class NewsArticle < ApplicationRecord
    # belongs_to :user
    

    before_validation :to_titleized

    validates :title, presence: true, uniqueness: {case_sensitive: false}

    validates :description, presence: true

    validate :published_after_create
    
    # old
    # def publish
    #     self.published_at = DateTime.current.utc
    #     self.published_at
    # end
    
  def publish
    update(published_at: Time.zone.now)
  end

#   scope :published, -> { where( 'published_at > created_at' ) }

#   # Same as
#   def self.published
#     where( 'published_at > created_at' )
#   end


private

def to_titleized
  self.title = self.title&.titleize
end

        def published_after_create
            return unless published_at.present?
            errors.add(:published_at, "You cannot immediately publish this article") if published_at <= created_at
        end
    
# old
    # def published_after_create
        
    #     errors.add(:published_at, "needs to be after created_at") if created_at && published_at && created_at >= published_at
    # end


end
