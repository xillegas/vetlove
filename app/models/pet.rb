SPECIES = ["Perro", "Gato", "Tortuga", "Conejo", "Hamster", "Ave", "Pez", "Capibara", "Serpiente", "Cerdo", "Caballo"]
GENDERS = ['Macho', 'Hembra']
class Pet < ApplicationRecord
  belongs_to :user
  has_many :bookings
end
