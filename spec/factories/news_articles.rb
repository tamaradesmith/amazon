  FactoryBot.define do
    factory :news_article do
      title {Faker::Nation.nationality }
      description { Faker::Hacker.say_something_smart }
      # association(:user, factory: :user)
      user
    end

  end