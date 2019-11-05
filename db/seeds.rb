puts 'destroying all old seeds'
Ride.destroy_all
User.destroy_all
ServiceType.destroy_all
Car.destroy_all


NOMBRES = [
 'Gerardo Raiden',
 'Nicolas Kennedy',
 'Santiago Llapur',
 'Agustin Greissing',
 'Alejo Gonzales Chaves',
 'Andres Cerutti',
 'Enzo Monteverdi',
 'Luxs Zhang'
]
AVATAR = [
  'https://ca.slack-edge.com/T02NE0241-UKCMT2EHY-f941ee395885-512',
  'https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/jjnpprepy6ktoh1afgdz.jpg',
  'https://avatars0.githubusercontent.com/u/49813028?v=4',
  'https://avatars2.githubusercontent.com/u/54517348?v=4',
  'https://avatars2.githubusercontent.com/u/54602482?v=4',
  'https://avatars3.githubusercontent.com/u/54422197?v=4',
  'https://avatars3.githubusercontent.com/u/55401087?v=4',
  'https://ca.slack-edge.com/T02NE0241-UK84XQMRN-c12de7874ee2-512'
]

EMAILS = [
  'gerardo@boxfull.com',
  'nicolas@elsemillerocoworking.com',
  'santillapur@gmail.com',
  'agusgreissing@gmail.com',
  'alejogch@gmail.com',
  'afcerutti@gmail.com',
  'enzomonteverdi@gmail.com',
  'luxszhang@gmail.com'
]

CITY = [
  'San Miguel De Tucuman',
  'Buenos Aires',
  'Buenos Aires',
  'Santa Fe',
  'Buenos Aires',
  'San Rafael De Mendoza',
  'Mendoza',
  'Buenos Aires'
]

ADDRESS = [
  'Av. El lucero 1873',
  'Nuñez 2310',
  'Luis Maria Campos 2246',
  'Escalabrini Ortiz 1680',
  'Tortugas Country Club 525',
  'Los Franceses 880',
  'Rodriguez Peña 1065',
  'Juncal 2542'
]

DNI = [
 '25444222',
 '30107894',
 '41907554',
 '33677318',
 '39760552',
 '37780874',
 '39383797',
 '38069267'
]
DRIVER_NOMBRES = [
 'Fancisco Rodriguez',
 'Guillermo Gimenez',
 'Claudio Sanchez',
 'Benjamin Gonzales',
 'Gaston Lascano',
 'Martin Suarez',
 'Lucas Smith',
 'Marcos Passerotti'
]

DRIVER_AVATAR = [
  'https://randomuser.me/api/portraits/men/1.jpg',
  'https://randomuser.me/api/portraits/men/12.jpg',
  'https://randomuser.me/api/portraits/men/17.jpg',
  'https://randomuser.me/api/portraits/men/18.jpg',
  'https://randomuser.me/api/portraits/men/10.jpg',
  'https://randomuser.me/api/portraits/men/19.jpg',
  'https://randomuser.me/api/portraits/men/11.jpg',
  'https://randomuser.me/api/portraits/men/13.jpg',
]

DRIVER_EMAILS = [
  'frodriguez@gmail.com',
  'ggimenez@gmail.com',
  'claudio_sanchez@gmail.com',
  'benjamin_gon@gmail.com',
  'glascano@gmail.com',
  'msuarez@gmail.com',
  'lsmith@gmail.com',
  'marcos_passerotti@gmail.com'
]

DRIVER_CITY = [
  'San Miguel De Tucuman',
  'Buenos Aires',
  'Buenos Aires',
  'Santa Fe',
  'Buenos Aires',
  'San Rafael De Mendoza',
  'Mendoza',
  'Buenos Aires'
]

DRIVER_ADDRESS = [
  'Av. Cordoba 3344',
  'Libertador 4578',
  'Armenia 6078',
  'Las Araucarias 2245',
  'Uruguay 1987',
  'Montevideo 3074',
  'Callao 6078',
  'Marquez 3475'
]

DRIVER_DNI = [
 '34444222',
 '27107894',
 '1807554',
 '22677318',
 '19760552',
 '27780874',
 '35383797',
 '38069457'
]


puts 'generating new seeds'


service1 = ServiceType.new(
  name: "One way trip",
  price: 100
)
service1.save!

service2 = ServiceType.new(
  name: "Multiple ways trip",
  price: 85
)
service2.save!

NOMBRES.each_with_index do |nombre, index|
passenger = User.new(
  full_name: nombre,
  email: EMAILS[index],
  photo: AVATAR[index],
  city: CITY[index],
  address: ADDRESS[index],
  dni: DNI[index],
  role: "Passenger",
  password: "123456",
  password_confirmation: "123456"
)
passenger.save!


driver = User.new(
  full_name: DRIVER_NOMBRES[index],
  email: DRIVER_EMAILS[index],
  photo: DRIVER_AVATAR[index],
  city: DRIVER_CITY[index],
  address: DRIVER_ADDRESS[index],
  dni: DRIVER_DNI[index],
  role: "Driver",
  password: "123456",
  password_confirmation: "123456"
)
driver.save!
ride_time = rand(1..12).hour
start_time = DateTime.now + rand(-12..12).hour
actual_start_time = start_time > DateTime.now ? false : start_time + rand(0..2).hour

ride = Ride.new(
  origin: "Innovation Lab, Niceto vega 1886",
  destination: "Ezeiza international airport",
  start_time: start_time,
  end_time: start_time + ride_time,
  user: passenger,
  driver: driver,
  service_type: [service1, service2].sample
)

  ride.estimated_price = (ride.end_time.to_time.to_i - ride.start_time.to_time.to_i) / 3600 * service1.price

  if actual_start_time
    ride.actual_start_time = actual_start_time
    ride.actual_end_time = actual_start_time + ride_time + rand(0..90).minute
    ride.total_price = (ride.actual_end_time.to_time.to_i - ride.actual_start_time.to_time.to_i) / 3600 * service1.price
  end


 ride.save!


# puts 'generating new car seeds'
# car = Car.new(
# brand: "Toyota",
# year: 2012,
# model: "Corolla",
# transmission: "Manual",
# poliza: "TC-AA-2020",
# green_card: "AAas20FGG20",
# fuel_type: "Nafta",
# plate: "OGT-123",
# user: passenger
# )
# car.save!

end


