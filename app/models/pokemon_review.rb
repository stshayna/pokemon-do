class PokemonReview < ApplicationRecord
  belongs_to :user
  belongs_to :booking

  validates :content, :rating, presence: true
  validates :rating, numericality: { greater_than: -1, less_than: 6 }
end
