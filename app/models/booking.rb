class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :pokemon

  has_many :pokemon_review

  validates_presence_of :user, :pokemon, :start_date, :end_date
  # maybe add validation for booking status
end
