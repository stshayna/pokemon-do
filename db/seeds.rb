# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Pokemon.destroy_all

Pokemon.create!(
  name: "Pikachu",
  description: "Pikachu's special ability is Static, which can cause paralysis in battle if hit by a physical move.",
  location: "Montreal",
  price: 150
)
