puts 'destroying all old seeds'
Ride.destroy_all
User.destroy_all
ServiceType.destroy_all
Car.destroy_all

puts 'generating new seeds'
user = User.new(
full_name: "Gaspar Baldunciel",
email: "gasparbaldunciel@gmail.com",
city: "Buenos Aires, Argentina",
address: "Necochea golf club 3113",
dni: "40106489",
role: "Passenger",
password: "123456",
password_confirmation: "123456"
  )
user.save

1.times do
  passenger = User.new(
full_name: Faker::Name.name,
email: Faker::Internet.email,
city: Faker::Address.city,
address: "Necochea golf club 311",
dni: Faker::IDNumber.brazilian_citizen_number,
role: "Passenger",
password: "123456",
password_confirmation: "123456"
  )
  passenger.save
  driver = User.new(
full_name: Faker::Name.name,
email: Faker::Internet.email,
city: Faker::Address.city,
address: "Necochea golf club 311",
dni: Faker::IDNumber.brazilian_citizen_number,
role: "Driver",
password: "123456",
password_confirmation: "123456"
  )
  driver.save
service = ServiceType.new(
  name: "One way trip",
  price: 100
)

service.save
  ride = Ride.new(status: "pending",
 origin: "Innovation Lab, Niceto vega 1886",
 destination: "Ezeiza international airport",
 start_time: DateTime.now - rand(4..7).hour,
 end_time: DateTime.now - rand(1..3).hour,
 actual_start_time: DateTime.now - rand(4..7).hour,
 actual_end_time: DateTime.now - rand(1..3).hour,
 user: passenger,
 driver: driver,
 service_type: service
)

 ride.estimated_price = (ride.end_time.hour - ride.start_time.hour) * service.price
 ride.total_price = (ride.actual_end_time.hour - ride.actual_start_time.hour) * service.price

 ride.save

puts 'generating new car seeds'
car = Car.new(
brand: "Toyota",
year: 2012,
model: "Corolla",
transmission: "Manual",
poliza: "TC-AA-2020",
green_card: "AAas20FGG20",
fuel_type: "Nafta",
plate: "OGT-123",
user: user
)
car.save

end


