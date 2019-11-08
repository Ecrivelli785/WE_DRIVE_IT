require "open-uri"
require 'uri'
require "json"

module TripHelper
  # GEOCODING_BASE_URL = "https://api.mapbox.com/geocoding/v5/mapbox.places"
  # def self.get_coordinates(address)
  #   data = open("#{GEOCODING_BASE_URL}/#{URI.encode(address)}.json?access_token=#{ENV['MAPBOX_API_KEY']}").read
  #   response = JSON.parse(data)
  #   response["features"][0]["geometry"]["coordinates"]
  #   raise
  # end

  DIRECTION_BASE_URL = "https://api.mapbox.com/directions-matrix/v1/mapbox/driving-traffic"
  def self.get_travel_time(origin, destination)
    origin_coordinates = origin.join(",")
    destination_coordinates = destination.join(",")
    data = open("#{DIRECTION_BASE_URL}/#{origin_coordinates};#{destination_coordinates}?access_token=#{ENV['MAPBOX_API_KEY']}").read
    response = JSON.parse(data)
    return response["durations"][0][1] / 60
  end
end
