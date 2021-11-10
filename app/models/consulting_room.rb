class ConsultingRoom < ApplicationRecord
  has_many :bookings, dependent: :destroy
  belongs_to :user
  validates :name, uniqueness: true
  validates :specific_address, presence: true
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
  # geocoded_by :address
  # reverse_geocoded_by :latitude, :longitude
  # after_validation :geocode, :reverse_geocode, if: ->(obj){ obj.address.present? && obj.address_changed? }
  # after_validation :lat_changed?

  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [:name, :address, :description],
    using: {
              tsearch: { prefix: true } # <-- now `superman batm` will return something!
            }
end
