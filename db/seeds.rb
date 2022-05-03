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
Booking.destroy_all
User.destroy_all

user_demo = User.create!(
  email: "demo@pokemondo.com",
  username: "demo",
  password: "demo123"
)

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

# Creating bookings as an owner who rented their Pokémons
2.times do
  puts "Creating upcoming bookings"
  @booking = Booking.create!(
    user_id: User.first.id,
    pokemon: Pokemon.all.sample,
    start_date: Faker::Date.between(from: 3.days.from_now, to: 5.days.from_now),
    end_date: Faker::Date.between(from: 5.days.from_now, to: 10.days.from_now)
  )
  puts "#{User.first.username} just booked #{@pokemon.name}!"

  puts "Creating  present bookings"
  @booking = Booking.create!(
    user_id: User.first.id,
    pokemon: Pokemon.all.sample,
    start_date: Faker::Date.between(from: 3.days.ago, to: Date.today),
    end_date: Faker::Date.between(from: Date.today, to: 3.days.from_now)
  )
  puts "#{User.first.username} just booked #{@pokemon.name}!"

  puts "Creating past bookings"
  @booking = Booking.create!(
    user_id: User.first.id,
    pokemon: Pokemon.all.sample,
    start_date: Faker::Date.between(from: 15.days.ago, to: 10.days.ago),
    end_date: Faker::Date.between(from: 10.days.ago, to: 2.days.ago)
  )
  puts "#{User.first.username} just booked #{@pokemon.name}!"
end

puts ''
puts "Finished catching pokemons :)"
