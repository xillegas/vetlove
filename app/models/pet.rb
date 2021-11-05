SPECIES = ["Perro", "Gato", "Tortuga", "Conejo", "Hamster", "Ave", "Pez", "Capibara", "Serpiente", "Cerdo", "Caballo"]
GENDERS = ['Macho', 'Hembra']
class Pet < ApplicationRecord
  belongs_to :user
  has_many :bookings
  validates :gender, inclusion: GENDERS, presence: true
  validates :species, inclusion: SPECIES, presence: true
  validates :birthdate, presence: true
  validates :name, presence: true
  validate :birthdate_lower_than_actual_date

  def birthdate_lower_than_actual_date
    return if self.birthdate.blank?
    if self.birthdate >= Date.current.to_s
      errors.add(:birthdate, "Birthdate can't be greather than today date")
    end
  end
end
