class Ride < ApplicationRecord
  before_validation :set_status

  # enum status: ["pending", "in_progress", "completed", "cancelled"]

  belongs_to :user
  belongs_to :service_type
  belongs_to :driver, class_name: 'User', foreign_key: "driver_id"
  # validates :status, presence: true
  # , inclusion: { in: status.keys }
  validates :origin, presence: true
  validates :destination, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  def set_status
    if !actual_start_time.nil? && actual_end_time.nil?
      self.status = "in_progress"
    elsif !actual_start_time.nil? && !actual_end_time.nil?
      self.status = "completed"
    else
      self.status = "pending"
    end
  end

end
