# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Wipes database
puts "Releasing Pokemons to the wild and clearing the database"
puts ''
Pokemon.destroy_all
User.destroy_all
Booking.destroy_all

# Main user for demo (owner and renter)
@demo_user = User.create!(
  email: 'pokemondo@lewagon.com',
  username: 'Jerry',
  password: '123456'
)

# Creates a total of 6 pokemons for demo user, 3 with bookings.
def seed_pokemons_and_owner_bookings
  3.times do
    pokemon = Pokemon.create!(
      user_id: @demo_user.id,
      name: Faker::Games::Pokemon.name,
      description: Faker::Games::Pokemon.move,
      location: Faker::Address.full_address,
      price: rand(100..200)
    )
  end
  3.times do
    pokemon = Pokemon.create!(
      user_id: @demo_user.id,
      name: Faker::Games::Pokemon.name,
      description: Faker::Games::Pokemon.move,
      location: Faker::Address.full_address,
      price: rand(100..200)
    )
    renter = User.create!(
      email: Faker::Internet.email,
      username: Faker::Name.first_name + Faker::Name.first_name,
      password: '123456'
    )
    booking = Booking.create!(
      pokemon_id: pokemon.id,
      user_id: renter.id,
      start_date: 20220501,
      end_date: 20220503
    )
  end
end

seed_pokemons_and_owner_bookings

# Bookings dates to sample from
start_dates = [20220501, 20220502, 20220503, 20220504, 20220505]
end_dates = [20220506, 20220507, 20220508, 20220509, 20220510]

# Seed database with 20 pokemons, users and bookings
20.times do
  pokemon_owner = User.create!(
    email: Faker::Internet.email,
    # Faker first name used twice for username to have a higher chance at a unique username with no spaces.
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )
  puts "Pokemon trainer #{pokemon_owner.username} was born!"

  pokemon = Pokemon.create!(
    user_id: pokemon_owner.id,
    name: Faker::Games::Pokemon.name,
    description: Faker::Games::Pokemon.move,
    location: Faker::Address.full_address,
    price: rand(100..200)
  )
  puts "#{pokemon_owner.username} just caught #{pokemon.name}!"
  puts ''

  pokemon_renter = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )
  puts "#{pokemon_renter.username} just signed up to rent pokemons"

  # Owner booking gets created same time as client booking
  Booking.create!(
    pokemon_id: pokemon.id,
    user_id: pokemon_renter.id,
    start_date: start_dates.sample,
    end_date: end_dates.sample
  )

  puts "#{pokemon_renter.username} just rented #{pokemon_owner.username}'s pokemon: #{pokemon.name}"
  puts ''
end
puts "Finished catching pokemons :)"
