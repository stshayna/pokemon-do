class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookings
  has_many :pokemons, dependent: :destroy
  has_many :pokemon_reviews, through: :bookings

  validates_presence_of :email, :username, :password
end

# Validate uniqueness to username if devise doesn't handle that by default.
# validates :uniqueness, :email, :user
