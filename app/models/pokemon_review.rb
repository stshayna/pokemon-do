class PokemonReview < ApplicationRecord
  belongs_to :user
  belongs_to :booking

  validates :content, :rating, presence: true
  validates :rating, numericality: { in: 0..5 }
end
