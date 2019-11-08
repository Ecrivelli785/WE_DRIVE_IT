require "open-uri"
require 'uri'
require "json"

puts 'destroying all old seeds'
Ride.destroy_all
User.destroy_all
ServiceType.destroy_all
Car.destroy_all
Choice.destroy_all
Question.destroy_all

GEOCODING_BASE_URL = "https://api.mapbox.com/geocoding/v5/mapbox.places"
def get_coordinates(address)
  data = open("#{GEOCODING_BASE_URL}/#{URI.encode(address)}.json?access_token=#{ENV['MAPBOX_API_KEY']}").read
  p address
  response = JSON.parse(data)
  response["features"][0]["geometry"]["coordinates"]
end

DIRECTION_BASE_URL = "https://api.mapbox.com/directions-matrix/v1/mapbox/driving-traffic"
def get_travel_time(origin, destination)
  origin_coordinates = get_coordinates(origin).join(",")
  destination_coordinates = get_coordinates(destination).join(",")
  data = open("#{DIRECTION_BASE_URL}/#{origin_coordinates};#{destination_coordinates}?access_token=#{ENV['MAPBOX_API_KEY']}").read
  response = JSON.parse(data)
  answer = response["durations"][0][1] / 60
end

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

RIDE_ORIGIN = [
  'San Martin de Tours 2908, Buenos Aires, Argentina',
  'Nuñez 2310, Buenos Aires, Argentina',
  'Luis Maria Campos 2246, Buenos Aires, Argentina',
  'Scalabrini Ortiz 168, Buenos Aires, Argentina',
  'Las Camelias 3324, Manuel Alberti, Buenos Aires',
  'Buenos Aires Golf Club, Lote 345, Bella Vista, Buenos Aires, Argentina',
  'Av. Diego Carman 555, B1642 San Isidro, Buenos Aires',
  'La Maquinita Co, Niceto Vega 2345, Palermo, Buenos Aires, Argentina'
]

REVIEW_CONTENT= [
  'En mi viaje desde We Work a Ezeiza tuve la oportunidad de conocer a Franciso. Un Hombre que me atendio muy bien, dandome una charla muy interesante acerca de politica. Vale destacar su capacidad de manejo dependiendo de las circunstancias, en cuanto si habia trafico o no, el viaje fue muy placenterto siempre.',
  'Hoy tuve que hacer un viaje un poco mas largo desde mi casa a Zarate, y WE DRIVE IT y el choffer Guillermo me ayudaron mucho a bajar mi stress y poder estar concentrado en una reunion telefonica y no en el manejo y el tiempo perdido que me hubiese generado no poder hacer esa llamada.',
  'Excelente persona Claudio, en todo momento muy atento tanto conmigo como con el cuidado de mi auto. Recomiendo el servicio para que andar en auto sea un momento de reflexion o calma y no de stress.',
  'Me gustaria destacar la puntualidad de Benjamin, estando 10 minutos de lo requerido. El slogan "You dont wait for us, we wait for you" es simplemente perfecto para este servicio.',
  'Tuve que realizar un viaje a Rosario de trabajo y fue una gran experiencia haber usado el servicio. Gaston una persona muy interesante para conversar, en cuanto al manejo simplemente perfecto.',
  'Gracias a Martin Suarez hoy el trafico no fue un problema, se disfruto del viaje con buena musica de fondo mientras leia un libro al cual no estaba encontrando momento para leerlo.',
  'Excelente experiencia. Gracias Lucas por el servicio y haber podido llevarme el auto a hacer el service.',
  'Marcos un gran conductor. Buena forma de poder ir a una reunion de trabajo preparando lo que voy a presentar y no preocupado en el trafico.'
]

REVIEW_RATING = [
  4,
  5,
  4,
  4,
  5,
  5,
  4,
  5
]

RIDE_DESTINATION = [
  'Aeropuerto Internacional Ezeiza, Buenos Aires, Argentina',
  'Las Lucilas 5567,Zarate, Buenos Aires, Buenos Aires, Argentina',
  'Los Lagartos Country Club, Km 47 Pilar, Buenos Aires, Argentina',
  'Bv. Oroño,, Rosario, Santa Fe, Argentina',
  'Rosario Vera Peñaloza 599, Buenos Aires, Argentina',
  'Calle 48 869, B1900 La Plata, Buenos Aires, Argentina',
  'Av. del Libertador 4625, Buenos Aires, Argentina',
  'Patricias Argetinas 3347, garin, Buenos Aires, Argentina'
]

CAR_BRAND = [
  'Volvo',
  'Audi',
  'Toyota',
  'Hyundai',
  'BMW',
  'Mercedes Benz',
  'Jaguar',
  'BMW'
]

CAR_MODEL = [
  'V70',
  'A5',
  'Land Cruiser',
  'Genesis',
  'M4',
  'E63 AMG',
  'F-Type',
  'X6'
]

CAR_PHOTO = [
  'https://images.unsplash.com/photo-1506244856291-8910ea843e81?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
  'https://images.unsplash.com/photo-1540066019607-e5f69323a8dc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
  'https://images.unsplash.com/photo-1569670380585-19bb0feec807?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
  'https://images.unsplash.com/photo-1571037697753-e796f324bbd6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
  'https://images.unsplash.com/photo-1495817102464-eff18fa9ffcb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
  'https://images.unsplash.com/photo-1563720223634-2f182fee259e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
  'https://images.unsplash.com/photo-1507136566006-cfc505b114fc?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60',
  'https://images.unsplash.com/photo-1518613158449-d23f7e69dfb4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60'
]

CAR_POLIZA = [
  'TC-AA-2020',
  'TC-AB-3074',
  'TY-AD-1015',
  'TR-AA-2029',
  'TQ-LA-2122',
  'TC-BB-2524',
  'TC-TT-1514',
  'TC-AA-7018',
]

CAR_GREEN_CARD = [
  'AAC36596',
  'AAC45789',
  'AAC98021',
  'AAC77889',
  'AAC09067',
  'AAC24567',
  'AAC89024',
  'AAC56739',
]

CAR_PLATE = [
  'PJX-226',
  'AA 123 CD',
  'AD 654 BB',
  'OBJ 345',
  'AB 890 DC',
  'AC 987 AD',
  'MKI 890',
  'AA 879 BC',
]
puts 'generating new seeds'


service1 = ServiceType.new(
  name: "One way trip",
  price: 25
)
service1.save!

service2 = ServiceType.new(
  name: "Multiple ways trip",
  price: 20
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
)
driver.save!

ride_time = get_travel_time(RIDE_ORIGIN[index], RIDE_DESTINATION[index])
start_time = DateTime.now + rand(-12..12).minutes



ride = Ride.new(
  start_time: start_time,
  end_time: start_time + ride_time.minutes,
  total_time_ride: ride_time,
  user: passenger,
  driver: driver,
  content: "Any observations by the moment.",
  service_type: [service1, service2].sample
)

ride.estimated_price = ride_time * service1.price

actual_start_time = nil
if start_time < DateTime.now
  ride.actual_start_time = start_time + rand(-5..5).minutes
  ride.actual_end_time = ride.actual_start_time + ride_time + rand(0..10).minutes
  ride.total_price_cents = ride_time * service1.price
end


ride.save!

[RIDE_ORIGIN[index], RIDE_DESTINATION[index]].each do |location|
  Step.create!(address: location, ride: ride)
end

puts 'generating new car seeds'
car = Car.new(
brand: CAR_BRAND[index],
year: 2012,
model: CAR_MODEL[index],
transmission: Car::TRANSMISSIONS.sample,
poliza: CAR_POLIZA[index],
green_card: CAR_GREEN_CARD[index],
fuel_type: Car::FUEL_TYPE.sample,
plate: CAR_PLATE[index],
photo: CAR_PHOTO[index],
user: passenger
)
car.save!

puts 'generating new review seeds'

review = Review.new(
  content: REVIEW_CONTENT[index],
  rating: REVIEW_RATING[index],
  ride: ride,
)
review.save!


end

QUESTIONS = [
  {
    statement: "¿A qué factor se deben la mayoría de los siniestros viales?",
    kind: "",
    choices: [
      {
        declaration: "Al humano.",
        correct: true,
      },
      {
        declaration: "Al vehicular.",
        correct: false,
      },
      {
        declaration: "Al ambiental.",
        correct: false,
      }
    ]
  },
  {
    statement: "La Organización Mundial de la Salud manifiesta que el riesgo en la vía pública surge como resultado de diversos factores, ¿cuáles son?",
    kind: "",
    choices: [
      {
        declaration: "Humano, Vehicular y Ambiental.",
        correct: true,
      },
      {
        declaration: "Vehicular y Ambiental",
        correct: false,
      },
      {
        declaration: "Humano y Vehicular.",
        correct: false,
      }
    ]
  },
  {
    statement: "A fin de aumentar la propia seguridad y la de los demás, ¿a qué se debería poner atención durante la circulación?",
    kind: "",
    choices: [
      {
        declaration: "A las condiciones en que se encuentran: el automóvil, la infraestructura vial, las condiciones climáticas y el conductor.",
        correct: true,
      },
      {
        declaration: "Al estado del pavimento y al clima, en especial",
        correct: false,
      },
      {
        declaration: "Ninguna respuesta es correcta",
        correct: false,
      }
    ]
  },
  {
    statement: "¿A qué se denomina incidente de tránsito o incidente vial?",
    kind: "",
    choices: [
      {
        declaration: "Hecho que puede ser evitado, en el cual se produce daño a persona o cosa, en ocasión de circulación en la vía pública.",
        correct: true,
      },
      {
        declaration: "Hecho impredecible e inevitable en ocasión de circulación en la vía pública.",
        correct: false,
      },
      {
        declaration: "Hecho, evitable o no, que involucra daños a terceros",
        correct: false,
      }
    ]
  },
  {
    statement: "¿Qué debe hacer usted si su vehículo queda inmovilizado en un túnel?",
    kind: "",
    choices: [
      {
        declaration: "Apagar el motor, colocar las balizas portátiles, mantener encendidas las luces de posición e intermitentes y llamar al número de asistencia.",
        correct: true,
      },
      {
        declaration: "Dejar el vehículo cerrado y salir del túnel cuanto antes",
        correct: false,
      },
      {
        declaration: "Apagar todas las luces si el túnel está iluminado y solicitar auxilio a través del teléfono móvil.",
        correct: false,
      }
    ]
  },
  {
    statement: "En caso de participar de un siniestro vial, ¿de cuánto tiempo se dispone para dar aviso sobre el hecho a la compañía aseguradora del vehículo?",
    kind: "",
    choices: [
      {
        declaration: "72 horas.",
        correct: true,
      },
      {
        declaration: "24 horas.",
        correct: false,
      },
      {
        declaration: "48 horas.",
        correct: false,
      }
    ]
  },
  {
    statement: "La ubicación y posición de las placas de dominio del vehículo, ¿puede sufrir algún tipo de modificación?",
    kind: "",
    choices: [
      {
        declaration: "No, deben estar colocadas en el lugar y de forma reglamentaria.",
        correct: true,
      },
      {
        declaration: "Sólo pueden, eventualmente, ampliarse para mejorar su visibilidad.",
        correct: false,
      },
      {
        declaration: "Sólo está prohibido modificar la placa de dominio trasera, no así la delantera.",
        correct: false,
      }
    ]
  },
  {
    statement: "¿Cuál es el tiempo promedio de reacción de un conductor desde que percibe un peligro hasta que acciona el freno?",
    kind: "",
    choices: [
      {
        declaration: "Aproximadamente 1 segundo.",
        correct: true,
      },
      {
        declaration: "Entre 2 y 3 segundos.",
        correct: false,
      },
      {
        declaration: "Es inmediato, no transcurre tiempo entre estas acciones.",
        correct: false,
      }
    ]
  },
  {
    statement: "Cuando un semáforo cambia de luz roja a verde, está habilitando a reiniciar la marcha; no obstante ello, ¿qué precauciones se deben adoptar?",
    kind: "",
    choices: [
      {
        declaration: "Todas las respuestas son correctas.",
        correct: true,
      },
      {
        declaration: "Permitir, antes de avanzar, que complete el cruce otro vehículo o peatón que ya lo haya iniciado.",
        correct: false,
      },
      {
        declaration: "No iniciar el cruce si no hay espacio para ubicar el vehículo del otro lado sin obstruir la circulación transversal.",
        correct: false,
      }
    ]
  },
  {
    statement: "En materia de señalamiento horizontal, ¿qué se entiende por “isleta”?",
    kind: "",
    choices: [
      {
        declaration: "Son las marcas canalizadoras de tránsito. No se puede traspasar o circular sobre ellas.",
        correct: true,
      },
      {
        declaration: "Son las rotondas.",
        correct: false,
      },
      {
        declaration: "Son los espacios reservados para estacionamiento exclusivo de motovehículos.",
        correct: false,
      }
    ]
  },
]

QUESTIONS.each do |question|
  p question
  puts "creating question"
  new_question = Question.create!(
    statement: question[:statement],
    kind: question[:kind]
  )
  question[:choices].each do |choice|
    puts "- creating choice"
    Choice.create!(
      declaration: choice[:declaration],
      correct: choice[:correct],
      question: new_question
    )
  end
end

