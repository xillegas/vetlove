class Booking < ApplicationRecord
  belongs_to :consulting_room
  belongs_to :pet
  has_one :record
  #Edicion de Alfredo
  has_one :user, through: :pet
  validate :validate_date_current

  def validate_date_current
    if self.date <= Date.current
      errors.add(:date, "No puedes crear un booking con fecha anterior a la actual")
    end
  end
end
