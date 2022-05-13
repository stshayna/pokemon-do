# List of pokemon species to sample from
species_file_path = File.join(Rails.root, 'app', 'assets', 'species.json')
species_file = File.read(species_file_path)
# Species list is an instance variable because I use it in a method
@species_list = JSON.parse(species_file)

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

# Reviews to sample from for each booking (tied to pokemon)
reviews = [
  {
    content: "I don't get the hype about that Pokemon. Kinda sucks!",
    rating: 1
  },
  {
    content: "Didn't help me at all, would not recommend!",
    rating: 1
  },
  {
    content: "I had a lot of difficulties with this pokemon, I'd be careful.",
    rating: 2
  },
  {
    content: "At first the pokemon was ok, but that didn't last very long at all.",
    rating: 2
  },
  {
    content: 'Meh. Not the best, but not the worst either.',
    rating: 3
  },
  {
    content: "The pokemon was OKAY I guess, but I probably won't rent it again",
    rating: 3
  },
  {
    content: "Awesome pokemon! It took a while for it to get comfortable around me though.",
    rating: 4
  },
  {
    content: "The only thing stopping me from rating 5 stars, is that it pooped in my house once.",
    rating: 4
  },
  {
    content: 'Da BEST Pokemon to ever walk this earth!',
    rating: 5
  },
  {
    content: 'Fantastic pokemon, I would definitely recommend and rent again!',
    rating: 5
  }
]

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

# Prevents Gary from having other plusle and minun pokemons for demo
def avoid_duplicate_cuties
  cuties = %w[plusle minun]
  species = @species_list.sample
  species = @species_list.sample while cuties.include?(species.downcase)
  species
end

# Second demo user Gary (owner).
demo_owner = User.create!(
  email: 'owner@pokemon.do',
  username: 'Gary',
  password: '123456'
)
demo_owner_address = '5333 Av. Casgrain'
puts "#{'✓'.green} Demo owner: #{demo_owner.username.light_cyan} is ready to rent out his pokemons:"
puts '-'.light_black

# This section is commented out because Gary has way too many pokemons
# Creates x amount of pokemon for demo_user Gary (to own) with no bookings.
# 3.times do
#   species = @species_list.sample
#   Pokemon.create!(
#     user_id: demo_owner.id,
#     name: Faker::Creature::Dog.name,
#     species: species,
#     description: Faker::Games::Pokemon.move,
#     location: demo_owner_address,
#     price: rand(25..65),
#     image_url: "https://img.pokemondb.net/artwork/large/#{species.downcase}.jpg"
#   )
# end

#############################################################################
#-----------------------------CURRENT BOOKINGS------------------------------#
#############################################################################

# Creates x amount of current bookings. Each booking will have a generated renter and pokemon.
# The owner of the pokemons in the bookings will be Gary, the demo owner user.
3.times do
  species = avoid_duplicate_cuties
  pokemon = Pokemon.create!(
    user_id: demo_owner.id,
    name: Faker::Creature::Dog.name,
    species: species,
    description: Faker::Games::Pokemon.move,
    location: demo_owner_address,
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

  species = @species_list.sample
  pokemon = Pokemon.create!(
    user_id: renter.id,
    name: Faker::Creature::Dog.name,
    species: species,
    description: Faker::Games::Pokemon.move,
    location: cities_list.sample,
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
  species = avoid_duplicate_cuties
  pokemon = Pokemon.create!(
    user_id: demo_owner.id,
    name: Faker::Creature::Dog.name,
    species: species,
    description: Faker::Games::Pokemon.move,
    location: demo_owner_address,
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

  species = @species_list.sample
  pokemon = Pokemon.create!(
    user_id: renter.id,
    name: Faker::Creature::Dog.name,
    species: species,
    description: Faker::Games::Pokemon.move,
    location: cities_list.sample,
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
  species = avoid_duplicate_cuties
  pokemon = Pokemon.create!(
    user_id: demo_owner.id,
    name: Faker::Creature::Dog.name,
    species: species,
    description: Faker::Games::Pokemon.move,
    location: demo_owner_address,
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{species.downcase}.jpg"
  )

  renter = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )

  booking = Booking.create!(
    pokemon_id: pokemon.id,
    user_id: renter.id,
    start_date: Faker::Date.between(from: 15.days.ago, to: 10.days.ago),
    end_date: Faker::Date.between(from: 10.days.ago, to: 2.days.ago)
  )
end

# Creates specific pokemon to make a past booking with during demo, owner is Gary (pokemon_id: to_confirm?)
demo_pokemon = Pokemon.create!(
user_id: demo_owner.id,
name: 'Hercules',
species: 'machamp',
description: 'Great for heavy lifting and building!',
location: demo_owner_address,
price: 25,
image_url: "https://img.pokemondb.net/artwork/large/machamp.jpg"
)
# Adds renter to leave a review
reviewing_renter = User.create!(
  email: 'reviewer@pokemon.do',
  username: 'Andrii',
  password: '123456'
)
reviewing_renter_two = User.create!(
  email: 'reviewer_two@pokemon.do',
  username: 'JF',
  password: '123456'
)
reviewing_renter_three = User.create!(
  email: 'reviewer_three@pokemon.do',
  username: 'Joe',
  password: '123456'
)
# Makes booking so renter can leave a review
demo_booking = Booking.create!(
  pokemon_id: demo_pokemon.id,
  user_id: reviewing_renter.id,
  start_date: Faker::Date.between(from: 15.days.ago, to: 10.days.ago),
  end_date: Faker::Date.between(from: 10.days.ago, to: 2.days.ago)
)
demo_booking_two = Booking.create!(
  pokemon_id: demo_pokemon.id,
  user_id: reviewing_renter_two.id,
  start_date: Faker::Date.between(from: 15.days.ago, to: 10.days.ago),
  end_date: Faker::Date.between(from: 10.days.ago, to: 2.days.ago)
)
demo_booking_three = Booking.create!(
  pokemon_id: demo_pokemon.id,
  user_id: reviewing_renter_three.id,
  start_date: Faker::Date.between(from: 15.days.ago, to: 10.days.ago),
  end_date: Faker::Date.between(from: 10.days.ago, to: 2.days.ago)
)
# Adds reviews for the demo booking pokemon
PokemonReview.create!(
  content: reviews[7][:content],
  rating: reviews[7][:rating],
  booking: demo_booking,
  user: reviewing_renter
)
PokemonReview.create!(
  content: reviews[8][:content],
  rating: reviews[8][:rating],
  booking: demo_booking_two,
  user: reviewing_renter_two
)
PokemonReview.create!(
  content: reviews[9][:content],
  rating: reviews[9][:rating],
  booking: demo_booking_three,
  user: reviewing_renter_three
)

# Creates x amount of past bookings. Each booking, Gary RENTED the pokemon.
# The owner of the pokemons in the bookings will be a new generated renter.
8.times do
  renter = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )

  species = @species_list.sample
  pokemon = Pokemon.create!(
    user_id: renter.id,
    name: Faker::Creature::Dog.name,
    species: species,
    description: Faker::Games::Pokemon.move,
    location: cities_list.sample,
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

# Creates cute 'minun' pokemon for demo, it'll be Gary's last pokemon
Pokemon.create!(
  user_id: demo_owner.id,
  name: 'Cutie patootie',
  species: 'Minun',
  description: 'Gives great hugs!',
  location: '5353 Casgrain Av',
  price: 80,
  image_url: "https://img.pokemondb.net/artwork/large/minun.jpg"
)
# Creates a 'machamp' pokemon + its owner with a far location, to compare with Gary's pokemon during demo day
renter = User.create!(
  email: Faker::Internet.email,
  username: Faker::Name.first_name + Faker::Name.first_name,
  password: '123456'
)

Pokemon.create!(
  user_id: renter.id,
  name: 'Muscles',
  description: 'Can break rocks better than you can!',
  location: '1925 Brookdale Dorval',
  species: 'machamp',
  price: 34,
  image_url: "https://img.pokemondb.net/artwork/large/machamp.jpg"
)

# Seed database with x amount of pokemons and their owner.
50.times do
  pokemon_owner = User.create!(
    email: Faker::Internet.email,
    username: Faker::Name.first_name + Faker::Name.first_name,
    password: '123456'
  )
  print "Pokemon owner #{pokemon_owner.username.light_cyan}(ID: #{pokemon_owner.id.to_s.light_cyan}) signed up and started renting out their "

  species = avoid_duplicate_cuties
  pokemon = Pokemon.create!(
    user_id: pokemon_owner.id,
    name: Faker::Creature::Dog.name,
    species: species,
    description: Faker::Games::Pokemon.move,
    location: cities_list.sample,
    price: rand(25..65),
    image_url: "https://img.pokemondb.net/artwork/large/#{species.downcase}.jpg"
  )
  puts "#{pokemon.name.cyan} the #{pokemon.species.magenta}(ID: #{pokemon.id.to_s.magenta})!"
  puts ''
  puts '----------------------------------------------------------------------------------------------------'.light_black
  puts ''
end

# Creates a 'machamp' pokemon and its owner with a high price, to compare with Gary's pokemon during demo day.
# The machamp will have 3 star review
renter = User.create!(
  email: Faker::Internet.email,
  username: Faker::Name.first_name + Faker::Name.first_name,
  password: '123456'
)

pokemon = Pokemon.create!(
  user_id: renter.id,
  name: 'Goliath',
  description: 'Has strong arms for heavy lifting',
  location: cities_list.sample,
  species: 'Machamp',
  price: 99,
  image_url: "https://img.pokemondb.net/artwork/large/machamp.jpg"
)

booking = Booking.create!(
  pokemon_id: pokemon.id,
  user_id: demo_owner.id,
  start_date: Faker::Date.between(from: 15.days.ago, to: 10.days.ago),
  end_date: Faker::Date.between(from: 10.days.ago, to: 2.days.ago)
)

PokemonReview.create!(
  content: reviews[5][:content],
  rating: reviews[5][:rating],
  booking: booking,
  user: booking.user
)

puts 'Creating reviews for each pokemon booked'.light_blue

# Seeds reviews for each booking (tied to pokemon)
Booking.all.each do |booking|
  unless booking.pokemon.name == 'Hercules' || booking.pokemon.name == 'Goliath'
    review_details = reviews.sample
    review = PokemonReview.create!(
      content: review_details[:content],
      rating: review_details[:rating],
      booking: booking,
      user: booking.user
    )
    puts "#{booking.user.username.cyan} rated #{review.booking.pokemon.name.magenta} #{review.rating.to_s.yellow} stars!"
    puts ''
    puts '-------------------------------'.light_black
    puts ''
  end
end

# Makes a booking so we can leave a review as Gary, who RENTED the pokemon
renter = User.create!(
  email: Faker::Internet.email,
  username: Faker::Name.first_name + Faker::Name.first_name,
  password: '123456'
)

species = avoid_duplicate_cuties
pokemon = Pokemon.create!(
  user_id: renter.id,
  name: Faker::Creature::Dog.name,
  species: species,
  description: 'Greatest pokemon!',
  location: 'Montreal, Lasalle',
  price: rand(65),
  image_url: "https://img.pokemondb.net/artwork/large/#{species.downcase}.jpg"
)

booking = Booking.create!(
  pokemon_id: pokemon.id,
  user_id: demo_owner.id,
  start_date: Faker::Date.between(from: 15.days.ago, to: 10.days.ago),
  end_date: Faker::Date.between(from: 3.days.ago, to: 2.days.ago)
)

puts "Finished catching and preparing pokemons :)".light_green
