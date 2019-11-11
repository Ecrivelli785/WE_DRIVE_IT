class ServiceType < ApplicationRecord
  has_many :rides
  OPTIONS = ["Multiple ways trip", "One way trip"]
end
