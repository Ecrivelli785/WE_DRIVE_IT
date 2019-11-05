class Ride < ApplicationRecord
  belongs_to :user
  belongs_to :service_type
  belongs_to :driver, class_name: 'User', foreign_key: "driver_id"
  STATUS_LIST = ["pending", "in progress", "cancelled", "completed"]
  validates :status, presence: true, inclusion: { in: STATUS_LIST }
  validates :origin, presence: true
  validates :destination, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
