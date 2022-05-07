class Pokemon < ApplicationRecord
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  has_many :bookings
  has_many :pokemon_reviews, through: :bookings
  belongs_to :user
  has_one_attached :photo

  validates_presence_of :name, :description, :location, :price

  def self.recent(max = 3)
    limit(max).order(created_at: :desc)
  end
end

# Validate uniqueness of pokemon later
# validates :name, uniqueness: { scope: :name, blah blah blah}
