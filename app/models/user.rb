class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :rides
  has_many :cars, dependent: :destroy
  has_one :driver_requirement
  mount_uploader :photo, PhotoUploader

  # validates :dni, uniqueness: true, presence: true
  # validates :email, uniqueness: true, presence: true
  # validates :full_name, presence: true
  # validates :city, presence: true
  # validates :address, presence: true
  def driver?
    role == "driver"
  end

  def passenger?
    role == "passenger"
  end
end
