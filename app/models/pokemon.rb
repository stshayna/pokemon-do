class Pokemon < ApplicationRecord
  has_many :bookings
  has_many :pokemon_reviews, through: :bookings

  belongs_to :user

  has_one_attached :photo

  validates_presence_of :name, :description, :location, :price

  def self.recent(max = 3)
    limit(max).order(created_at: :desc)
  end

  # added "pg_search" gem to filter the index by owner and pokemon's name/description
  include PgSearch::Model
  pg_search_scope :search_index,
    against: %i[name description],
    associated_against: { user: :username },
    using: { tsearch: { prefix: true } }
end

# Validate uniqueness of pokemon later
# validates :name, uniqueness: { scope: :name, blah blah blah}
