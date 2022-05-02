# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'

puts "Releasing Pokemons to the wild"
puts ''
Pokemon.destroy_all

10.times do
  @user = User.create!(
    email: Faker::Internet.email,
    # Faker first name used twice to have a higher chance at a unique username when seeding.
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )
  puts "Pokemon trainer #{@user.username} was born!"
end

10.times do
  pokemon_name = Faker::Games::Pokemon.name
  @pokemon = Pokemon.create!(
    user_id: @user.id,
    name: Faker::Games::Pokemon.name,
    description: Faker::Games::Pokemon.move,
    location: Faker::Address.full_address,
    price: rand(100..200),
    image_url: "https://img.pokemondb.net/artwork/large/#{pokemon_name.downcase}.jpg"
  )
  puts "#{@user.username} just caught #{@pokemon.name}!"
end

puts "Creating bookings"
@booking = Booking.create!(
  user_id: User.first.id,
  pokemon_id: Pokemon.second.id,
  start_date: "2022-05-03",
  end_date: "2022-05-05"
)
puts "#{User.first.username} just booked #{Pokemon.second.name}!"

puts ''
puts "Finished catching pokemons :)"
