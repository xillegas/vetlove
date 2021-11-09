class ConsultingRoom < ApplicationRecord
  has_many :bookings
  belongs_to :user
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  validates :name, uniqueness: true

  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [:name, :address, :description],
    using: {
              tsearch: { prefix: true } # <-- now `superman batm` will return something!
            }
end
