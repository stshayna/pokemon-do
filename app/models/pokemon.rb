class Pokemon < ApplicationRecord
  has_many :bookings
  belongs_to :user

  validates_presence_of :name, :description, :location, :price

end

# Validate uniqueness of pokemon later
# validates :name, uniqueness: { scope: :name, blah blah blah}
