class Pokemon < ApplicationRecord
  # Uncomment this if you'd like to use a map with the Geocoder gem
  # geocoded_by :location
  # after_validation :geocode, if: :will_save_change_to_location?

  has_many :bookings, dependent: :destroy
  belongs_to :user
  has_one_attached :photo

  validates_presence_of :name, :description, :location, :price
end

# Validate uniqueness of pokemon later
# validates :name, uniqueness: { scope: :name, blah blah blah}
