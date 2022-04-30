# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Releasing Pokemons to the wild"
puts ''
Pokemon.destroy_all

10.times do
  @user = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name,
    password: '123456'
  )
  puts "Pokemon trainer #{@user.username} was born!"

  @pokemon = Pokemon.create!(
    user_id: @user.id,
    name: "Pikachu",
    description: Faker::Games::Pokemon.move,
    location: Faker::Address.full_address,
    price: rand(100..200)
  )
  puts "#{@user.username} just caught #{@pokemon.name}!"
end

puts ''
puts "Finished catching pokemons :)"
