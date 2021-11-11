class ConsultingRoom < ApplicationRecord
  has_many :bookings, dependent: :destroy
  belongs_to :user
  validates :name, uniqueness: true
  validates :specific_address, presence: true
  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
  validates :latitude, :longitude, :init_hour_day, :end_hour_day, :description, :week_days, :animal, :specific_address, presence: true
  # geocoded_by :address
  # reverse_geocoded_by :latitude, :longitude
  # after_validation :geocode, :reverse_geocode, if: ->(obj){ obj.address.present? && obj.address_changed? }
  # after_validation :lat_changed?

  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [:name, :address, :description, :specific_address],
    using: {
              tsearch: { prefix: true } # <-- now `superman batm` will return something!
            }
end
