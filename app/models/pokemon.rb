class Pokemon < ApplicationRecord
  has_many :bookings
  has_many :pokemon_reviews, through: :bookings

  belongs_to :user

  has_one_attached :photo

  validates_presence_of :name, :description, :location, :price

  def self.recent(max = 3)
    limit(max).order(created_at: :desc)
  end

  def average_rating
    return nil if pokemon_reviews.blank?

    total = 0
    pokemon_reviews.each do |p_review|
      total += p_review.rating
    end
    total / pokemon_reviews.length
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
