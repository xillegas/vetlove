class ConsultingRoom < ApplicationRecord
  has_many :bookings
  belongs_to :user
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  validates :name, uniqueness: true
end
