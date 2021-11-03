SPECIES = ["Dog", "Cat", "Turtle", "Rabbit", "Hamster", "Bird", "Fish", "Ferret", "Snake", "Guinea pig" ]
GENDERS = %w[Male Female]
class Pet < ApplicationRecord
  belongs_to :user
  has_many :bookings
  validates :gender, inclusion: GENDERS, presence: true
  validates :species, inclusion: SPECIES, presence: true
  validates :birthdate, presence: true
  validates :name, presence: true
end
