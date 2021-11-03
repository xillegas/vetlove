class Booking < ApplicationRecord
  belongs_to :consulting_room
  belongs_to :pet
  has_one :record
  #Edicion de Alfredo
  has_one :user, through: :pet
end
