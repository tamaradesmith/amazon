# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.destroy_all

NUM_PRODUCTS = 1000

NUM_PRODUCTS.times do
    created_at = Faker::Date.backward(days: 365 * 5)
    Product.create(
        title: Faker::Cannabis.strain,
        description: Faker::Cannabis.health_benefit,
        price:rand(500.00),
    created_at: created_at,
    updated_at: created_at
    )
end
    products = Product.all

    puts Cowsay.say("Generated #{products.count} products", :frogs)