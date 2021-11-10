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

# Mi propio faker seed
tlf_area = ['212','414','412','416','424','426']

puts "Empezará a insertar datos"
puts "Insertando Usuarios"
puts ""
User.create([{ email: "fernando@gmail.com",
  first_name: "Fernando", last_name: "Lopez", password: "123456", password_confirmation: "123456",
  phone_number: "+58#{tlf_area.sample}#{Faker::PhoneNumber.subscriber_number(length: 7)}",
  birthdate: Faker::Date.between(from: "1980-09-23", to: "2002-09-25"), is_vet: true }])
puts "Usuario: fernando@gmail.com, Contraseña: 123456, Tipo: Veterinario"

User.create([{ email: "alfredo@gmail.com", first_name: "Alfredo", last_name: "Peña", password: "123456", password_confirmation: "123456",
  phone_number: "+58#{tlf_area.sample}#{Faker::PhoneNumber.subscriber_number(length: 7)}",
  birthdate: Faker::Date.between(from: "1980-09-23", to: "2002-09-25"), is_vet: true }])
puts "Usuario: alfredo@gmail.com, Contraseña: 123456, Tipo: Veterinario"

User.create([{ email: "genesis@gmail.com", first_name: "Genesis", last_name: "Perez", password: "123456", password_confirmation: "123456",
  phone_number: "+58#{tlf_area.sample}#{Faker::PhoneNumber.subscriber_number(length: 7)}",
  birthdate: Faker::Date.between(from: "1980-09-23", to: "2002-09-25"), is_vet: true }])
puts "Usuario: genesis@gmail.com, Contraseña: 123456, Tipo: Veterinario"

User.create([{ email: "jesus@gmail.com", first_name: "Jesus", last_name: "Lopez", password: "123456", password_confirmation: "123456",
  phone_number: "+58#{tlf_area.sample}#{Faker::PhoneNumber.subscriber_number(length: 7)}",
  birthdate: Faker::Date.between(from: "1980-09-23", to: "2002-09-25"), is_vet: false }])
puts "Usuario: jesus@gmail.com, Contraseña: 123456, Tipo: Cliente"

User.create([{ email: "javier@gmail.com", first_name: "Javier", last_name: "Lopez", password: "123456", password_confirmation: "123456",
  phone_number: "+58#{tlf_area.sample}#{Faker::PhoneNumber.subscriber_number(length: 7)}",
  birthdate: Faker::Date.between(from: "1980-09-23", to: "2002-09-25"), is_vet: false }])
puts "Usuario: javier@gmail.com, Contraseña: 123456, Tipo: Cliente"

User.create([{ email: "juan@gmail.com", first_name: "Juan", last_name: "Lopez", password: "123456", password_confirmation: "123456",
  phone_number: "+58#{tlf_area.sample}#{Faker::PhoneNumber.subscriber_number(length: 7)}",
  birthdate: Faker::Date.between(from: "1980-09-23", to: "2002-09-25"), is_vet: false }])
puts "Usuario: juan@gmail.com, Contraseña: 123456, Tipo: Cliente"

User.create([{ email: "maria@gmail.com", first_name: "Maria", last_name: "Lopez", password: "123456", password_confirmation: "123456",
  phone_number: "+58#{tlf_area.sample}#{Faker::PhoneNumber.subscriber_number(length: 7)}",
  birthdate: Faker::Date.between(from: "1980-09-23", to: "2002-09-25"), is_vet: false }])
puts "Usuario: maria@gmail.com, Contraseña: 123456, Tipo: Cliente"

User.create([{ email: "tumascotafeliz@gmail.com", first_name: "Rafael", last_name: "Gosling", password: "123456", password_confirmation: "123456",
  phone_number: "+582129630719", birthdate: 20020925, is_vet: true }])
puts "Usuario: tumascotafeliz@gmail.com, Contraseña: 123456, Tipo: Veterinario"

pet_species = ["Perro", "Gato", "Tortuga", "Conejo", "Hamster", "Ave", "Capibara", "Serpiente", "Cerdo", "Caballo"]

descr_first = ["En nuestro consultorio", "Nosotros", "Somos centro médico veterinario,", "Nosotros en nuestro centro veterinario", "Estamos cerca de ti y", "Consultiorio veterinario,", "Salud para tu mascota,","Somos salud para tus mascotas,", "Con más de 30 años de actividad,", "Con más de 20 años de actividad,", "Con 20 años en el servicio de salud a las mascotas,", "Somos uno de los consultorios más reconocidos,", "Somos profesionales en la salud,"]

descr_second = ["contamos con gran variedad de servicios de atención a tu mascota.", "brindamos la salud para los peludos de la casa.", "brindamos atención personalizada.", "contamos con lo más avanzado en salud veterinaria.", "tenemos los más avanzados equipos.", "hacemos felices a los peludos.", "los peludos reciben amor y cariño.", "ofrecemos citas a buen precio,"]

descr_offer = ["Nos especializamos en perros y gatos.", "Ofrecemos servicios de esterilización a gatos.", "Hacemos esterilización a perros.", "Tenemos venta de medicinas y artículos para tu mascota.", "Abrimos en horario corrido.", "Tenemos atención via telefónica.", "Hacemos descuentos a animales de la comunidad.", "Especialistas en perros.", "Somos especialistas en gatos.", "Dedicados a animales de apoyo.", "Atención a domicilo.", "Además atendemos caballos de carrera.", "Operación de la vista a perros.", "Jornadas de vacunación."]

descr_last = ["La salud de tu mascota es nuestra prioridad.", "Estamos para tu mascota.", "Pensamos en tu mascota.", "A tu mascota la queremos.", "Tu mascota será feliz.", "", "Cerca de ti.", "Somos amigos de los peludos.", "Siempre cerca de tu mascota.", "Somos felicidad y amor a tu mascota."]
# municipios = ["Baruta", "El Hatillo", "Libertador", "Chacao", "Sucre"]
direcciones = ["Av. Intercomunal del Valle, C.C. El Valle, Municipìo Libertador, Caracas.",
               "C.C. Concresa, Municipìo Baruta, Caracas.",
               "Calle Cumana, Urbanización Las Palmas Edf. Merida, PB, Local A Caracas, 1050, Distrito Capital",
               "Av. González Rincones, Baruta, Caracas 1080, Miranda",
               "Av. Sta. María, Caracas 1060, Distrito Capital",
               "Edf. Andrea. PB, Local 4. (Al lado de la Torre KPMG), Caracas, Miranda",
               "Avenida Lecuna Edif. El Tejar, Local CB-17, Parque Central, Caracas 1010, Distrito Capital",
               "Calle paez, edif obelisco a, local A y B, Caracas 1060, Miranda",
               "Av. El Ejército, Caracas 1020, Distrito Capital",
               "F4QC+9FQ, Caracas 1080, Miranda"]
# 10.times do
# puts "#{descr_first.sample} #{descr_second.sample} #{descr_offer.sample} #{descr_last.sample}"
# puts ""
# end
puts ""
puts "Insertando ConsultingRoom"
vet_genesis = User.find_by(email: "genesis@gmail.com")
vet_fernando = User.find_by(email: "fernando@gmail.com")
ConsultingRoom.create([{ specific_address: "Av. Río de Janeiro, Caracas 1061, Distrito Capital",
                           name: "Consultorio Dr. #{vet_fernando.first_name} #{vet_fernando.last_name}",
                           description: "#{descr_first.sample} #{descr_second.sample} #{descr_offer.sample} #{descr_last.sample}",
                           latitude: rand(10.507955..10.513019),
                           longitude: rand(-66.938838..-66.930598),
                           init_hour_day: Faker::Time.between_dates(from: Date.today, to: Date.today, period: :morning),
                           end_hour_day: Faker::Time.between_dates(from: Date.today, to: Date.today, period: :evening),
                           week_days: "lunes,martes,miercoles,jueves,viernes",
                           animal: "Perro Gato #{pet_species[2..].sample(2).join(" ")}", #Esto es lo nuevo.
                           user: vet_fernando }])

vet_alfredo = User.find_by(email: "alfredo@gmail.com")
ConsultingRoom.create([{ specific_address: "Av. Nueva Granada, C.C. Multiplaza Caracas 1041, Distrito Capital",
                           name: "Consultorio Dr. #{vet_alfredo.first_name} #{vet_alfredo.last_name}",
                           description: "#{descr_first.sample} #{descr_second.sample} #{descr_offer.sample} #{descr_last.sample}",
                           latitude: rand(10.507055..10.523019),
                           longitude: rand(-66.940838..-66.930598),
                           init_hour_day: Faker::Time.between_dates(from: Date.today, to: Date.today, period: :morning),
                           end_hour_day: Faker::Time.between_dates(from: Date.today, to: Date.today, period: :evening),
                           week_days: "lunes,martes,miercoles,jueves,viernes",
                           animal: "Perro Gato #{pet_species[2..].sample(2).join(" ")}", #Esto es lo nuevo.
                           user: vet_alfredo }])

# Necesito más consultorios para probar la busqueda
# Entonces Genesis atiende en varios consultorios con nombres aleatorios
cons_name = ['Patas', 'Patitas', 'Garras', 'Huellas', 'Narices Frias', 'Garritas', 'Mascotas']
cons_adjetivo = ['Felices', 'Contentas', "Amor", 'Sanas', 'Salud', 'Amorosas', 'Saludables', 'Vivas', 'Perez', 'Happy', 'Peludas']
direcciones.each do |dir|
  ConsultingRoom.create([{ specific_address: dir,
                           name: "Consultorio Veterinario #{cons_name.sample} #{cons_adjetivo.sample}",
                           description: "#{descr_first.sample} #{descr_second.sample} #{descr_offer.sample} #{descr_last.sample}",
                           latitude: rand(10.517055..10.523019),
                           longitude: rand(-66.940838..-66.930598),
                           init_hour_day: Faker::Time.between_dates(from: Date.today, to: Date.today, period: :morning),
                           end_hour_day: Faker::Time.between_dates(from: Date.today, to: Date.today, period: :evening),
                           week_days: "lunes,martes,miercoles,jueves,viernes",
                           animal: "Perro Gato #{pet_species[2..].sample(2).join(" ")}",
                           user: vet_genesis}])
end

# Consultorio real!
vet_mascotafeliz = User.find_by(email: "tumascotafeliz@gmail.com")
  ConsultingRoom.create([{ specific_address: "Carretera El Hatillo, Los Naranos, vía El Seminario. Centro Veterinario Dr. Gosling. Caracas- Venezuela",
                           name: "Consultorio Veterinario Dr. Gosling",
                           description: "Contamos con Tecnología de punta en área de Quirófanos, Laboratorio, Radiología, Imagenología, Hospitalización, Cuidados Intensivos, Peluquería  y Transporte en Ambulancia. Atendido por médicos especializados las 24 horas del día, con Veterinario residente.",
                           latitude: rand(10.517055..10.523019),
                           longitude: rand(-66.940838..-66.930598),
                           init_hour_day: Faker::Time.between_dates(from: Date.today, to: Date.today, period: :morning),
                           end_hour_day: Faker::Time.between_dates(from: Date.today, to: Date.today, period: :evening),
                           week_days: "lunes,martes,miércoles,jueves,viernes,sábado,domingo",
                           animal: "Perro Gato Capibara",
                           user: vet_mascotafeliz}])

puts ""
puts "Insertando Pets"
pet_gender = ['Macho', 'Hembra']
User.all.each do |user|
  Pet.create([{ name: Faker::Creature::Dog.name,
                gender: pet_gender.sample,
                birthdate: Faker::Date.between(from: "2010-09-23", to: "2021-09-25"),
                species: pet_species.sample,
                user: (user unless user.is_vet) }])
end

puts ""
puts "Insertando Bookings"
# Manera ruby
User.all.each_with_index do |user, index|
  Booking.create([{ date: Faker::Time.between_dates(from: Date.today + index, to: Date.today + index, period: :morning),
                    consulting_room: ConsultingRoom.find(rand(1..3)),
                    attended: false,
                    pet: Pet.find_by(user: user) }])
end

puts ""
puts "Insertando Records"

# Booking.all.each do |booking|
#   Record.create([{ symptoms: Faker::Lorem.paragraph_by_chars,
#                    diagnostic: Faker::Lorem.paragraph_by_chars,
#                    treatment: Faker::Lorem.paragraph_by_chars,
#                    booking: booking }])
# end

puts ""
puts "Seed Completado"
puts ""
