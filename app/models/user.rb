class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create :send_welcome_email
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :rides
  has_many :cars, dependent: :destroy
  has_one :driver_requirement
  mount_uploader :photo, PhotoUploader

  validates :dni, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates :full_name, presence: true
  validates :city, presence: true
  validates :address, presence: true
  validates :phone, presence: true

  def driver?
    role == "driver"
  end

  def passenger?
    role == "passenger"
  end

  private

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end
end
