class Ride < ApplicationRecord

  STEPS = {
    "One way trip" => ["Punto de partida", "Destino"],
    "Multiple ways trip" => ["Punto de partida", "Destino principal", "Punto de regreso"]
  }

  enum status: ["CANCELADO", "PENDIENTE", "ASIGNADO", "EN CAMINO", "HE LLEGADO", "COMENZAR VIAJE", "VIAJE TERMINADO"]
  has_many :reviews, dependent: :destroy
  has_many :steps, dependent: :destroy
  accepts_nested_attributes_for :steps
  belongs_to :user
  belongs_to :service_type
  belongs_to :driver, class_name: 'User', foreign_key: "driver_id", optional: true
  # validates :status, presence: true
  # , inclusion: { in: status.keys }
  validates :start_time, presence: true
  validates :end_time, presence: true

  def set_status
    unless status == "completed"
      if !actual_start_time.nil? && actual_end_time.nil?
        self.status = "in_progress"
      elsif !actual_start_time.nil? && !actual_end_time.nil?
        self.status = "completed"
      else
        self.status = ["pending", "cancelled"].sample
      end
    end
  end

  def completed?
    status == "completed"
  end
end
