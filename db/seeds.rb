# List of pokemon species to sample from
species_file_path = File.join(Rails.root, 'app', 'assets', 'species.json')
species_file = File.read(species_file_path)
species_list = JSON.parse(species_file)

# List of montreal areas to sample from
cities_file_path = File.join(Rails.root, 'app', 'assets', 'cities.json')
cities_file = File.read(cities_file_path)
cities_list = JSON.parse(cities_file)

# Clears screen and wipes database
system('clear')
puts "Releasing Pokemons to the wild and clearing the database".red.blink
puts ''
Booking.destroy_all
Pokemon.destroy_all
User.destroy_all
PokemonReview.destroy_all

#############################################################################
#--------------------------------RENTER-------------------------------------#
#############################################################################

# First demo user Jerry (renter).
demo_renter = User.create!(
  email: 'renter@pokemon.do',
  username: 'Jerry',
  password: '123456'
)
puts "#{'✓'.green} Demo renter: #{demo_renter.username.light_cyan} is ready to rent pokemons:"
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
demo_owner_address = '1925 brookdale dorval'
puts "#{'✓'.green} Demo owner: #{demo_owner.username.light_cyan} is ready to rent out his pokemons:"
puts '-'.light_black

# Creates x amount of pokemon for demo_user Gary (to own) with no bookings.
3.times do
  species = species_list.sample
  Pokemon.create!(
    user_id: demo_owner.id,
    name: Faker::Creature::Dog.name,
    species: species,
    description: Faker::Games::Pokemon.move,
    location: demo_owner_address,
    # latitude: Faker::Address.latitude,
    # longitude: Faker::Address.longitude,
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{species.downcase}.jpg"
  )
end

# Creates specific pokemon to make a booking with duriong demo, owner is Gary (pokemon_id: 5)
Pokemon.create!(
  user_id: demo_owner.id,
  name: Faker::Creature::Dog.name,
  species: 'Graveler',
  description: 'Great for demolition!',
  location: demo_owner_address,
  # latitude: Faker::Address.latitude,
  # longitude: Faker::Address.longitude,
  price: 24,
  image_url: "https://img.pokemondb.net/artwork/large/graveler.jpg"
)

#############################################################################
#-----------------------------CURRENT BOOKINGS------------------------------#
#############################################################################

# Creates x amount of current bookings. Each booking will have a generated renter and pokemon.
# The owner of the pokemons in the bookings will be Gary, the demo owner user.
3.times do
  species = species_list.sample
  pokemon = Pokemon.create!(
    user_id: demo_owner.id,
    name: Faker::Creature::Dog.name,
    species: species,
    description: Faker::Games::Pokemon.move,
    location: demo_owner_address,
    # latitude: Faker::Address.latitude,
    # longitude: Faker::Address.longitude,
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{species.downcase}.jpg"
  )

  renter = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )

  Booking.create!(
    pokemon_id: pokemon.id,
    user_id: renter.id,
    start_date: Faker::Date.between(from: 3.days.ago, to: 2.days.ago),
    end_date: Faker::Date.between(from: 2.days.from_now, to: 3.days.from_now)
  )
end

# Creates x amount of current bookings. Each booking, Gary is RENTING the pokemon.
# The owner of the pokemons in the bookings will be a new generated renter.
1.times do
  renter = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )

  species = species_list.sample
  pokemon = Pokemon.create!(
    user_id: renter.id,
    name: Faker::Creature::Dog.name,
    species: species,
    description: Faker::Games::Pokemon.move,
    location: cities_list.sample,
    # latitude: Faker::Address.latitude,
    # longitude: Faker::Address.longitude,
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{species.downcase}.jpg"
  )

  Booking.create!(
    pokemon_id: pokemon.id,
    user_id: demo_owner.id,
    start_date: Faker::Date.between(from: 3.days.ago, to: 2.days.ago),
    end_date: Faker::Date.between(from: 2.days.from_now, to: 3.days.from_now)
  )
end

puts "#{'✓'.green} #{demo_owner.username.light_cyan}'s current bookings are ready."
puts '-'.light_black

#############################################################################
#----------------------------UPCOMING BOOKINGS------------------------------#
#############################################################################

# Creates x amount of upcoming bookings. Each booking will have a generated renter and pokemon.
# The owner of the pokemons in the bookings will be Gary, the demo owner user.
3.times do
  species = species_list.sample
  pokemon = Pokemon.create!(
    user_id: demo_owner.id,
    name: Faker::Creature::Dog.name,
    species: species,
    description: Faker::Games::Pokemon.move,
    location: demo_owner_address,
    # latitude: Faker::Address.latitude,
    # longitude: Faker::Address.longitude,
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{species.downcase}.jpg"
  )

  renter = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )

  Booking.create!(
    pokemon_id: pokemon.id,
    user_id: renter.id,
    start_date: Faker::Date.between(from: 3.days.from_now, to: 5.days.from_now),
    end_date: Faker::Date.between(from: 5.days.from_now, to: 10.days.from_now)
  )
end

# Creates x amount of upcoming bookings. Each booking, Gary is RENTING the pokemon.
# The owner of the pokemons in the bookings will be a new generated renter.
2.times do
  renter = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )

  species = species_list.sample
  pokemon = Pokemon.create!(
    user_id: renter.id,
    name: Faker::Creature::Dog.name,
    species: species,
    description: Faker::Games::Pokemon.move,
    location: cities_list.sample,
    # latitude: Faker::Address.latitude,
    # longitude: Faker::Address.longitude,
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{species.downcase}.jpg"
  )

  Booking.create!(
    pokemon_id: pokemon.id,
    user_id: demo_owner.id,
    start_date: Faker::Date.between(from: 3.days.from_now, to: 5.days.from_now),
    end_date: Faker::Date.between(from: 5.days.from_now, to: 10.days.from_now)
  )
end

puts "#{'✓'.green} #{demo_owner.username.light_cyan}'s upcoming bookings are ready."
puts '-'.light_black

#############################################################################
#------------------------------PAST BOOKINGS--------------------------------#
#############################################################################

# Creates x amount of past bookings. Each booking will have a generated renter and pokemon.
# The owner of the pokemons in the bookings will be Gary, the demo owner user.
5.times do
  species = species_list.sample
  pokemon = Pokemon.create!(
    user_id: demo_owner.id,
    name: Faker::Creature::Dog.name,
    species: species,
    description: Faker::Games::Pokemon.move,
    location: demo_owner_address,
    # latitude: Faker::Address.latitude,
    # longitude: Faker::Address.longitude,
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{species.downcase}.jpg"
  )

  renter = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )

  Booking.create!(
    pokemon_id: pokemon.id,
    user_id: renter.id,
    start_date: Faker::Date.between(from: 15.days.ago, to: 10.days.ago),
    end_date: Faker::Date.between(from: 10.days.ago, to: 2.days.ago)
  )
end

# Creates x amount of past bookings. Each booking, Gary RENTED the pokemon.
# The owner of the pokemons in the bookings will be a new generated renter.
8.times do
  renter = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )

  species = species_list.sample
  pokemon = Pokemon.create!(
    user_id: renter.id,
    name: Faker::Creature::Dog.name,
    species: species,
    description: Faker::Games::Pokemon.move,
    location: cities_list.sample,
    # latitude: Faker::Address.latitude,
    # longitude: Faker::Address.longitude,
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{species.downcase}.jpg"
  )

  Booking.create!(
    pokemon_id: pokemon.id,
    user_id: demo_owner.id,
    start_date: Faker::Date.between(from: 15.days.ago, to: 10.days.ago),
    end_date: Faker::Date.between(from: 10.days.ago, to: 2.days.ago)
  )
end

puts "#{'✓'.green} #{demo_owner.username.light_cyan}'s past bookings are ready."
puts '-'.light_black

#############################################################################
#--------------------------SEEDING DB WITH POKEMONS-------------------------#
#############################################################################

# Creates a 'graveler' pokemon + its owner with a high price, to compare with Gary's pokemon during demo day
renter = User.create!(
  email: Faker::Internet.email,
  username: Faker::Name.first_name + Faker::Name.first_name,
  password: '123456'
)

Pokemon.create!(
  user_id: renter.id,
  name: 'graveler',
  description: 'Can break rocks better than you can!',
  location: cities_list.sample,
  species: species_list.sample,
  # latitude: Faker::Address.latitude,
  # longitude: Faker::Address.longitude,
  price: 74,
  image_url: "https://img.pokemondb.net/artwork/large/graveler.jpg"
)

# Seed database with x amount of pokemons and their owner.
50.times do
  pokemon_owner = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )
  print "Pokemon owner #{pokemon_owner.username.light_cyan}(ID: #{pokemon_owner.id.to_s.light_cyan}) signed up and started renting out their "

  species = species_list.sample
  pokemon = Pokemon.create!(
    user_id: pokemon_owner.id,
    name: Faker::Creature::Dog.name,
    species: species,
    description: Faker::Games::Pokemon.move,
    location: cities_list.sample,
    # latitude: Faker::Address.latitude,
    # longitude: Faker::Address.longitude,
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{species.downcase}.jpg"
  )
  puts "#{pokemon.name.cyan} the #{pokemon.species.magenta}(ID: #{pokemon.id.to_s.magenta})!"
  puts ''
  puts '--------------------------------------------------'.light_black
  puts ''
end

# Creates a 'graveler' pokemon and its owner with a far location, to compare with Gary's pokemon during demo day
renter = User.create!(
  email: Faker::Internet.email,
  username: Faker::Name.first_name + Faker::Name.first_name,
  password: '123456'
)

Pokemon.create!(
  user_id: renter.id,
  name: 'graveler',
  description: 'Can be used as a wheel!',
  location: cities_list.sample,
  species: species_list.sample,
  latitude: Faker::Address.latitude,
  longitude: Faker::Address.longitude,
  price: 28,
  image_url: "https://img.pokemondb.net/artwork/large/graveler.jpg"
)
puts "Finished catching pokemons :)".light_green.blink

puts 'Creating one review per Pokemon booked'.light_blue

reviews = [
  {
    content: "I don't get the hype about that Pokemon. Kinda sucks!",
    rating: 1
  },
  {
    content: 'Meh. Not the best, but not the worst either.',
    rating: 3
  },
  {
    content: 'Da BEST Pokemon to ever walk this earth!',
    rating: 5
  }
]
Booking.all.each do |booking|
  review_details = reviews.sample
  PokemonReview.create!(
    content: review_details[:content],
    rating: review_details[:rating],
    booking: booking,
    user: booking.user
  )
end

puts "Adding review!".light_blue.blink
