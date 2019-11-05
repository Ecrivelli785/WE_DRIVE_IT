class Car < ApplicationRecord
  belongs_to :user
  has_many :rides, through: :user
  TRANSMISSIONS = ["AUTOMATICO", "MANUAL", "SEMI-AUTOMATICO"]
  FUEL_TYPE = ["NAFTA", "GASOIL"]
  validates :brand, presence: true
  validates :year, presence: true
  validates :model, presence: true
  validates :transmission, presence: true, inclusion: { in: TRANSMISSIONS }
  validates :fuel_type, presence: true, inclusion: { in: FUEL_TYPE }
  validates :poliza, presence: true
  validates :green_card, presence: true
  validates :plate, presence: true, uniqueness: true
end
