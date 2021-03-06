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
  accepts_nested_attributes_for :cars

  validates :dni, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates :encrypted_password, presence: true
  validates :full_name, presence: true
  validates :city, presence: true
  validates :phone, presence: true
  validates :license, presence: true, if: :is_driver?
  # accept_nested_resources_for :car

  def driver?
    role == "driver"
  end

  def passenger?
    role == "passenger"
  end

  def payment_method?
    mp_customer_id.present? && mp_card_id.present?
  end

  private


  def is_driver?
    role == "driver"
  end

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end
end
