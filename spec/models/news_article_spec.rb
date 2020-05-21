require 'rails_helper'



RSpec.describe NewsArticle, type: :model do

  describe "validates" do
    
    it "should requires a title" do
      # given
      news_article = NewsArticle.new
      # when
        news_article.valid?
      # then
        expect(news_article.errors.messages).to(have_key(:title))
    end

    it "should have a unique title" do
        # given
      persisted_news_article = NewsArticle.create(title: "Canada Votes", description: "here we go again")
      news_article = NewsArticle.new(title: persisted_news_article.title)
        # when
      news_article.valid?
        # Then
      expect(news_article.errors.messages).to have_key :title
      expect(news_article.errors.messages[:title]).to(include('has already been taken'))
    end
    
    it 'should have a desciption' do

      news_article = NewsArticle.new
      news_article.valid?
      expect(news_article.errors.messages).to have_key :description

    end

    it "ensures the published_at date is after the created_at date" do
      news_article =  NewsArticle.create({title: "Hudsons asks if it's time yet", description: "Hudson is again dispointed"})
      news_article.published_at = news_article.created_at
      news_article.valid?
      expect(news_article.errors).to have_key(:published_at)
    end

    # it 'should have published_at after created_at' do
    # # # given
    #   news_article = NewsArticle.create({title: "Hudsons asks if it's time yet", description: "Hudson is again dispointed", published_at: DateTime.current - 4.days})
    # # # when
    #   news_article.valid?
    # # # then
    #   expect(news_article.errors).to have_key(:published_at)
    # end
  end

  describe "create" do
    it "should titlize title" do
      # give
        news_article = NewsArticle.create(title: "hudson asks if its time yet", description: "NO!!!!!!!!!")
    # when
        
    # then
        expect(news_article.title).to eq "Hudson Asks If Its Time Yet"

    end

#     it("should have #publish that publishes with the current time") do
       it 'sets published_at to the current_date' do
       news_article = NewsArticle.new({
        title: "Publish me please",
        description: "Publish me please but a description"
      })
      news_article.save
      news_article.publish
      expect(news_article.published_at.to_i).to eq(Time.zone.now.to_i)
      
      # the Time.zone.now call when we call n.publish and the Time.zone.now call
      # in our expect statement will likely differ by fractional seconds. If we
      # don't care about those microsecond differences we can just call .to_i or
      # .to_s on them to ensure that this isn't what causes our test to fail.
    end




#       news_article = NewsArticle.new({
#         title: "Publish me please",
#         description: "Publish me please but a description"
#       })

#       current_time, published_at = DateTime.current.utc, news_article.publish

#       publish_time = news_article.published_at

#       expect(publish_time).to(be_within(1.seconds).of current_time)

#     end

  end
end
  