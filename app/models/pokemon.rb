class Pokemon < ApplicationRecord
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  has_many :bookings
  belongs_to :user
  has_one_attached :photo

  validates_presence_of :name, :description, :location, :price
end

# Validate uniqueness of pokemon later
# validates :name, uniqueness: { scope: :name, blah blah blah}
