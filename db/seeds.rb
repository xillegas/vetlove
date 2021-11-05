require "faker"
require "date"

puts "Borrando Record"
Record.destroy_all
puts "Borrando Booking"
Booking.destroy_all
puts "Borrando Pet"
Pet.destroy_all
puts "Borrando Consultorios"
ConsultingRoom.destroy_all
puts "Borrando usuarios"
User.destroy_all
puts ""
puts "Reiniciando secuencias"
ActiveRecord::Base.connection.reset_pk_sequence!("records")
ActiveRecord::Base.connection.reset_pk_sequence!("bookings")
ActiveRecord::Base.connection.reset_pk_sequence!("pets")
ActiveRecord::Base.connection.reset_pk_sequence!("consulting_rooms")
ActiveRecord::Base.connection.reset_pk_sequence!("users")
puts ""

puts "Empezará a insertar datos"
puts "Insertando Usuarios"
puts ""
User.create([{ email: "fernando@gmail.com", first_name: "fernando", last_name: "Lopez", password: "123456", password_confirmation: "123456", phone_number: Faker::PhoneNumber.cell_phone, birthdate: Faker::Date.between(from: "1990-09-23", to: "2014-09-25"), is_vet: true }])
puts "Usuario: fernando@gmail.com, Contraseña: 123456, Tipo: Veterinario"

User.create([{ email: "alfredo@gmail.com", first_name: "alfredo", last_name: "Lopez", password: "123456", password_confirmation: "123456", phone_number: Faker::PhoneNumber.cell_phone, birthdate: Faker::Date.between(from: "1990-09-23", to: "2014-09-25"), is_vet: true }])
puts "Usuario: alfredo@gmail.com, Contraseña: 123456, Tipo: Veterinario"

User.create([{ email: "genesis@gmail.com", first_name: "genesis", last_name: "Lopez", password: "123456", password_confirmation: "123456", phone_number: Faker::PhoneNumber.cell_phone, birthdate: Faker::Date.between(from: "1990-09-23", to: "2014-09-25"), is_vet: true }])
puts "Usuario: genesis@gmail.com, Contraseña: 123456, Tipo: Veterinario"

User.create([{ email: "jesus@gmail.com", first_name: "jesus", last_name: "Lopez", password: "123456", password_confirmation: "123456", phone_number: Faker::PhoneNumber.cell_phone, birthdate: Faker::Date.between(from: "1990-09-23", to: "2014-09-25"), is_vet: false }])
puts "Usuario: jesus@gmail.com, Contraseña: 123456, Tipo: Cliente"

User.create([{ email: "javier@gmail.com", first_name: "javier", last_name: "Lopez", password: "123456", password_confirmation: "123456", phone_number: Faker::PhoneNumber.cell_phone, birthdate: Faker::Date.between(from: "1990-09-23", to: "2014-09-25"), is_vet: false }])
puts "Usuario: javier@gmail.com, Contraseña: 123456, Tipo: Cliente"

User.create([{ email: "juan@gmail.com", first_name: "juan", last_name: "Lopez", password: "123456", password_confirmation: "123456", phone_number: Faker::PhoneNumber.cell_phone, birthdate: Faker::Date.between(from: "1990-09-23", to: "2014-09-25"), is_vet: false }])
puts "Usuario: juan@gmail.com, Contraseña: 123456, Tipo: Cliente"

User.create([{ email: "maria@gmail.com", first_name: "maria", last_name: "Lopez", password: "123456", password_confirmation: "123456", phone_number: Faker::PhoneNumber.cell_phone, birthdate: Faker::Date.between(from: "1990-09-23", to: "2014-09-25"), is_vet: false }])
puts "Usuario: maria@gmail.com, Contraseña: 123456, Tipo: Cliente"

puts ""
puts "Insertando ConsultingRoom"
User.all.each do |user|
  ConsultingRoom.create([{ address: Faker::Address.full_address,
                           name: Faker::Company.name,
                           description: Faker::Lorem.paragraph,
                           state: Faker::Address.state,
                           municipality: Faker::Address.city,
                           parish: Faker::Address.street_name,
                           latitude: (Faker::Address.latitude).to_f,
                           longitude: (Faker::Address.longitude).to_f,
                           init_hour_day: Faker::Time.between_dates(from: Date.today, to: Date.today, period: :morning),
                           end_hour_day: Faker::Time.between_dates(from: Date.today, to: Date.today, period: :evening),
                           week_days: "lunes,martes,miercoles,jueves,viernes",
                           user: (user if user.is_vet) }])
end

puts ""
puts "Insertando Pets"
User.all.each do |user|
  Pet.create([{ name: Faker::Creature::Dog.name,
                gender: Faker::Creature::Dog.gender,
                birthdate: Faker::Date.between(from: "2010-09-23", to: "2021-09-25"),
                species: ["Dog", "Cat", "Turtle", "Rabbit", "Hamster", "Bird", "Fish", "Ferret", "Snake", "Guinea pig" ].sample,
                user: (user if !user.is_vet )}])
end

puts ""
puts "Insertando Bookings"
# Manera ruby
User.all.each_with_index do |user, index|
  Booking.create([{ date: Faker::Time.between_dates(from: Date.today + index, to: Date.today + index, period: :morning),
                    time: Faker::Time.between_dates(from: Date.today + index, to: Date.today + index, period: :afternoon),
                    consulting_room: ConsultingRoom.find(rand(1..3)),
                    pet: Pet.find_by(user: user) }])
end

puts ""
puts "Insertando Records"

Booking.all.each do |booking|
  Record.create([{ symptoms: Faker::Lorem.paragraph_by_chars,
                   diagnostic: Faker::Lorem.paragraph_by_chars,
                   treatment: Faker::Lorem.paragraph_by_chars,
                   booking: booking }])
end

puts ""
puts "Seed Completado"
puts ""
