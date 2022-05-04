# !!! CERTAIN POKEMONS DON'T HAVE PICTURES such as Mr.Mine and Nidoran !!!
@bad_pokemon_names_for_api = ['nidoran', 'mr. mime', "farfetch'd"]

# Prevents pokemon with no image from seeding
def valid_pokemon_names_only
  name = Faker::Games::Pokemon.name
  name = Faker::Games::Pokemon.name while @bad_pokemon_names_for_api.include?(name.downcase)
  return name
end

# Wipes database
puts "Releasing Pokemons to the wild and clearing the database".red.blink
puts ''
Booking.destroy_all
Pokemon.destroy_all
User.destroy_all

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
3.times do
  pokemon_name = valid_pokemon_names_only
  pokemon = Pokemon.create!(
    user_id: demo_owner.id,
    name: pokemon_name,
    description: Faker::Games::Pokemon.move,
    location: Faker::Address.full_address,
    price: rand(25..65),
  image_url: "https://img.pokemondb.net/artwork/large/#{pokemon_name.downcase}.jpg"
  )
end

#############################################################################
#-----------------------------CURRENT BOOKINGS------------------------------#
#############################################################################

# Creates x amount of current bookings. Each booking will have a generated renter and pokemon.
# The owner of the pokemons in the bookings will be Gary, the demo owner user.
3.times do
  pokemon_name = valid_pokemon_names_only
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

  pokemon_name = valid_pokemon_names_only
  pokemon = Pokemon.create!(
    user_id: renter.id,
    name: pokemon_name,
    description: Faker::Games::Pokemon.move,
    location: Faker::Address.full_address,
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{pokemon_name.downcase}.jpg"
  )

  Booking.create!(
    pokemon_id: pokemon.id,
    user_id: demo_owner.id,
    start_date: Faker::Date.between(from: 3.days.ago, to: 2.days.ago),
    end_date: Faker::Date.between(from: 2.days.from_now, to: 3.days.from_now)
  )
end

puts "#{demo_owner.username.light_cyan}'s current bookings are ready."
puts '-'.light_black

#############################################################################
#----------------------------UPCOMING BOOKINGS------------------------------#
#############################################################################

# Creates x amount of upcoming bookings. Each booking will have a generated renter and pokemon.
# The owner of the pokemons in the bookings will be Gary, the demo owner user.
3.times do
  pokemon_name = valid_pokemon_names_only
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

  pokemon_name = valid_pokemon_names_only
  pokemon = Pokemon.create!(
    user_id: renter.id,
    name: pokemon_name,
    description: Faker::Games::Pokemon.move,
    location: Faker::Address.full_address,
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{pokemon_name.downcase}.jpg"
  )

  Booking.create!(
    pokemon_id: pokemon.id,
    user_id: demo_owner.id,
    start_date: Faker::Date.between(from: 3.days.from_now, to: 5.days.from_now),
    end_date: Faker::Date.between(from: 5.days.from_now, to: 10.days.from_now)
  )
end

puts "#{demo_owner.username.light_cyan}'s upcoming bookings are ready."
puts '-'.light_black

#############################################################################
#------------------------------PAST BOOKINGS--------------------------------#
#############################################################################

# Creates x amount of past bookings. Each booking will have a generated renter and pokemon.
# The owner of the pokemons in the bookings will be Gary, the demo owner user.
5.times do
  pokemon_name = valid_pokemon_names_only
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

  pokemon_name = valid_pokemon_names_only
  pokemon = Pokemon.create!(
    user_id: renter.id,
    name: pokemon_name,
    description: Faker::Games::Pokemon.move,
    location: Faker::Address.full_address,
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{pokemon_name.downcase}.jpg"
  )

  Booking.create!(
    pokemon_id: pokemon.id,
    user_id: demo_owner.id,
    start_date: Faker::Date.between(from: 15.days.ago, to: 10.days.ago),
    end_date: Faker::Date.between(from: 10.days.ago, to: 2.days.ago)
  )
end

puts "#{demo_owner.username.light_cyan}'s past bookings are ready."
puts '-'.light_black

#############################################################################
#--------------------------SEEDING DB WITH POKEMONS-------------------------#
#############################################################################

# Seed database with x amount of pokemons and their owner.
50.times do
  pokemon_owner = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )
  puts "Pokemon trainer #{pokemon_owner.username.cyan} was born!"

  pokemon_name = valid_pokemon_names_only
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

# Use the line below to create a booking for the live demo (for me: Denzel)
#                 Gary's pokemon       renter Jerry             Friday               Sunday
# Booking.create!(pokemon_id: 2, user_id: User.first.id, start_date: 20220506, end_date: 20220508)
