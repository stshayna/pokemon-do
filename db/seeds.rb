# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Releasing Pokemons to the wild"
Pokemon.destroy_all
temp_pokmeon_user_id = 1

10.times do
  @pokemon = Pokemon.create!(
    user_id: temp_pokmeon_user_id,
    name: "Pikachu",
    description: Faker::Games::Pokemon.move,
    location: Faker::Address.full_address,
    price: rand(100..200)
  )
  puts "Just caught #{@pokemon.name}!"
  temp_pokmeon_user_id += 1
end

puts "Finished catching pokemons :)"
