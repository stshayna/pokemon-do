# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Wipes database
puts "Releasing Pokemons to the wild and clearing the database".red.blink
puts ''
Pokemon.destroy_all
User.destroy_all
Booking.destroy_all

# Main user for demo (owner and renter)
demo_user = User.create!(
  email: 'pokemondo@lewagon.com',
  username: 'Jerry',
  password: '123456'
)
puts "Demo user: #{demo_user.username.light_cyan} created:"

# Creates a total of 6 pokemons for demo user, 3 with bookings.
3.times do
  pokemon_name = Faker::Games::Pokemon.name
  pokemon = Pokemon.create!(
    user_id: demo_user.id,
    name: pokemon_name,
    description: Faker::Games::Pokemon.move,
    location: Faker::Address.full_address,
    price: rand(100..200),
  image_url: "https://img.pokemondb.net/artwork/large/#{pokemon_name.downcase}.jpg"
  )
end
3.times do
  pokemon_name = Faker::Games::Pokemon.name
  pokemon = Pokemon.create!(
    user_id: demo_user.id,
    name: pokemon_name,
    description: Faker::Games::Pokemon.move,
    location: Faker::Address.full_address,
    price: rand(100..200),
  image_url: "https://img.pokemondb.net/artwork/large/#{pokemon_name.downcase}.jpg"
  )
  renter = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )
  booking = Booking.create!(
    pokemon_id: pokemon.id,
    user_id: renter.id,
    start_date: Faker::Date.between(from: 3.days.from_now, to: 5.days.from_now),
    end_date: Faker::Date.between(from: 5.days.from_now, to: 10.days.from_now)
  )
end
puts "#{demo_user.username.light_cyan} has 6 pokemons now, 3 with bookings"

# Creates 3 bookings for the demo user (from a renter perspective)
3.times do
  pokemon_owner = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )
  pokemon_name = Faker::Games::Pokemon.name
  pokemon = Pokemon.create!(
    user_id: pokemon_owner.id,
    name: pokemon_name,
    description: Faker::Games::Pokemon.move,
    location: Faker::Address.full_address,
    price: rand(100..200),
  image_url: "https://img.pokemondb.net/artwork/large/#{pokemon_name.downcase}.jpg"
  )
  booking = Booking.create!(
    pokemon_id: pokemon.id,
    user_id: demo_user.id,
    start_date: Faker::Date.between(from: 3.days.from_now, to: 5.days.from_now),
    end_date: Faker::Date.between(from: 5.days.from_now, to: 10.days.from_now)
  )
end
puts "#{demo_user.username.light_cyan} has 3 bookings of their own now!"
puts '--------------------------------------------------'.light_black

# Seed database with 20 pokemons, users and bookings
30.times do
  pokemon_owner = User.create!(
    email: Faker::Internet.email,
    # Faker first name used twice for username to have a higher chance at a unique username with no spaces.
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )
  puts "Pokemon trainer #{pokemon_owner.username.cyan} was born!"

  pokemon_name = Faker::Games::Pokemon.name
  pokemon = Pokemon.create!(
    user_id: pokemon_owner.id,
    name: pokemon_name,
    description: Faker::Games::Pokemon.move,
    location: Faker::Address.full_address,
    price: rand(100..200),
    image_url: "https://img.pokemondb.net/artwork/large/#{pokemon_name.downcase}.jpg"
  )
  puts "#{pokemon_owner.username.cyan} just caught #{pokemon.name.light_yellow}!"
  puts ''

  pokemon_renter = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )
  puts "#{pokemon_renter.username.light_green} just signed up to rent pokemons"

  # Owner booking gets created same time as client booking
  Booking.create!(
    pokemon_id: pokemon.id,
    user_id: pokemon_renter.id,
    start_date: Faker::Date.between(from: 3.days.from_now, to: 5.days.from_now),
    end_date: Faker::Date.between(from: 5.days.from_now, to: 10.days.from_now)
  )

  puts "#{pokemon_renter.username.light_green} just rented #{pokemon_owner.username.cyan}'s pokemon: #{pokemon.name.light_yellow}"
  puts '--------------------------------------------------'.light_black
  puts ''
end
puts "Finished catching pokemons :)"
