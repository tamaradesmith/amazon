class NewsArticle < ApplicationRecord

    before_save :to_titleized

    validates :title, presence: true, uniqueness: {case_sensitive:false}
    validates :description, presence: true
    validate :published_after_created
    
    def publish
        self.published_at = DateTime.current.utc
        self.published_at
    end
    
    
    private
    def to_titleized
        self.title = self.title.titleize  
    end

    def published_after_created
        
        errors.add(:published_at, "needs to be after created_at") if created_at && published_at && created_at >= published_at
    end
end
