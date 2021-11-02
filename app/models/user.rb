class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Relaciones
  has_one :consulting_room
  has_many :pets
  # Validar con pundit el acceso en función de is_vet
end
