class ConsultingRoom < ApplicationRecord
  has_many :bookings
  belongs_to :user
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, :reverse_geocode
  validates :name, uniqueness: true
  validates :specific_address, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [:name, :address, :description],
    using: {
              tsearch: { prefix: true } # <-- now `superman batm` will return something!
            }
end
