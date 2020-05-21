  FactoryBot.define do
    factory :news_article do
      title {Faker::Nation.nationality }
      # sequence(:title) { |n| Faker::Book.title + " #{n}" }
      description { Faker::Hacker.say_something_smart }
      association(:user_id, factory: :user)
      # user
    end

  end