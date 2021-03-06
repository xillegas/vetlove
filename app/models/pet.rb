SPECIES = ["Perro", "Gato", "Tortuga", "Conejo", "Hamster", "Ave", "Capibara", "Serpiente", "Cerdo", "Caballo"]
GENDERS = ['Macho', 'Hembra']
class Pet < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  validates :gender, inclusion: GENDERS, presence: true
  validates :species, inclusion: SPECIES, presence: true
  validates :birthdate, presence: true
  validates :name, presence: true
  validate :birthdate_lower_than_actual_date
  has_one_attached :photo
  def birthdate_lower_than_actual_date
    return if self.birthdate.blank?
    if self.birthdate >= Date.current.to_s
      errors.add(:birthdate, "Birthdate can't be greather than today date")
    end
  end
end
