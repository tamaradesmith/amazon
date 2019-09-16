  FactoryBot.define do
    factory :news_article do
      title {Faker::Nation.nationality }
      description { Faker::Hacker.say_something_smart }
    end
  end