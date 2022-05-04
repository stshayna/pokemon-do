# Wipes database
puts "Releasing Pokemons to the wild and clearing the database".red.blink
puts ''
Booking.destroy_all
Pokemon.destroy_all
User.destroy_all

# Main user for demo (owner and renter)
demo_user = User.create!(
  email: 'pokemondo@lewagon.com',
  username: 'Jerry',
  password: '123456'
)
puts "Demo user: #{demo_user.username.light_cyan} created:"

# Creates a total of 6 pokemons for demo user, 6 with bookings.
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

  puts "Creating upcoming bookings"
  booking = Booking.create!(
    pokemon_id: pokemon.id,
    user_id: renter.id,
    start_date: Faker::Date.between(from: 3.days.from_now, to: 5.days.from_now),
    end_date: Faker::Date.between(from: 5.days.from_now, to: 10.days.from_now)
  )

  puts "Creating past bookings"
  booking = Booking.create!(
    pokemon_id: pokemon.id,
    user_id: demo_user.id,
    start_date: Faker::Date.between(from: 15.days.ago, to: 10.days.ago),
    end_date: Faker::Date.between(from: 10.days.ago, to: 2.days.ago)
  )
end
puts "#{demo_user.username.light_cyan} has 6 pokemons now, 6 with bookings"

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
  puts "Creating upcoming bookings"
  booking = Booking.create!(
    pokemon_id: pokemon.id,
    user_id: demo_user.id,
    start_date: Faker::Date.between(from: 3.days.from_now, to: 5.days.from_now),
    end_date: Faker::Date.between(from: 5.days.from_now, to: 10.days.from_now)
  )

  puts "Creating past bookings"
  booking = Booking.create!(
    pokemon_id: pokemon.id,
    user_id: demo_user.id,
    start_date: Faker::Date.between(from: 15.days.ago, to: 10.days.ago),
    end_date: Faker::Date.between(from: 10.days.ago, to: 2.days.ago)
  )
end
puts "#{demo_user.username.light_cyan} has 6 bookings of their own now!"
puts '--------------------------------------------------'.light_black

#############################################################################
#--------------------------------RENTER-------------------------------------#
#############################################################################

# First demo user Jerry (renter).
demo_renter = User.create!(
  email: 'renter@pokemon.do',
  username: 'Jerry',
  password: '123456'
)
puts "Demo renter: #{demo_renter.username.light_cyan} is ready to rent pokemons:"
puts '-'.light_black

#############################################################################
#---------------------------------OWNER-------------------------------------#
#############################################################################

# Second demo user Gary (owner).
demo_owner = User.create!(
  email: 'owner@pokemon.do',
  username: 'Gary',
  password: '123456'
)
puts "Demo owner: #{demo_owner.username.light_cyan} is ready to rent out his pokemons:"
puts '-'.light_black

# Creates x amount of pokemon for demo_user Gary (to own) with no bookings.
4.times do
  pokemon_name = Faker::Games::Pokemon.name
  pokemon = Pokemon.create!(
    user_id: demo_owner.id,
    name: pokemon_name,
    description: Faker::Games::Pokemon.move,
    location: Faker::Address.full_address,
    price: rand(25..65),
  image_url: "https://img.pokemondb.net/artwork/large/#{pokemon_name.downcase}.jpg"
  )
end

# Creates x amount of current bookings, pokemons and users. Each booking will have a renter and a pokemon.
# The owner of the pokemons in the bookings will be Gary, the demo owner user.
3.times do
  pokemon_name = Faker::Games::Pokemon.name
  pokemon = Pokemon.create!(
    user_id: demo_owner.id,
    name: pokemon_name,
    description: Faker::Games::Pokemon.move,
    location: Faker::Address.full_address,
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{pokemon_name.downcase}.jpg"
  )

  renter = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )

  current_booking = Booking.create!(
    pokemon_id: pokemon.id,
    user_id: renter.id,
    start_date: Faker::Date.between(from: 3.days.ago, to: 2.days.ago),
    end_date: Faker::Date.between(from: 2.days.from_now, to: 3.days.from_now)
  )
end
puts "#{demo_owner.username.light_cyan}'s current bookings are ready."
puts '-'.light_black

# Creates x amount of past and future bookings, pokemons and users. Each booking will have a renter and a pokemon.
# The owner of the pokemons in the bookings will be Gary, the demo owner user.
5.times do
  pokemon_name = Faker::Games::Pokemon.name
  pokemon = Pokemon.create!(
    user_id: demo_owner.id,
    name: pokemon_name,
    description: Faker::Games::Pokemon.move,
    location: Faker::Address.full_address,
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{pokemon_name.downcase}.jpg"
  )

  renter = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )

  future_booking = Booking.create!(
    pokemon_id: pokemon.id,
    user_id: renter.id,
    start_date: Faker::Date.between(from: 3.days.from_now, to: 5.days.from_now),
    end_date: Faker::Date.between(from: 5.days.from_now, to: 10.days.from_now)
  )

  past_booking = Booking.create!(
    pokemon_id: pokemon.id,
    user_id: demo_owner.id,
    start_date: Faker::Date.between(from: 15.days.ago, to: 10.days.ago),
    end_date: Faker::Date.between(from: 10.days.ago, to: 2.days.ago)
  )
end
puts "#{demo_owner.username.light_cyan}'s past and future bookings are ready."
puts '--------------------------------------------------'.light_black

#############################################################################
#--------------------------SEEDING DB WITH POKEMONS-------------------------#
#############################################################################

# Seed database with x amount of pokemons.
30.times do
  pokemon_owner = User.create!(
    email: Faker::Internet.email,
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
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{pokemon_name.downcase}.jpg"
  )
  puts "#{pokemon_owner.username.cyan} just caught #{pokemon.name.light_yellow}!"
  puts ''
  puts '--------------------------------------------------'.light_black
  puts ''
end
puts "Finished catching pokemons :)"
