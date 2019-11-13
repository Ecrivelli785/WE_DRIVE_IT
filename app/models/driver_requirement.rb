class DriverRequirement < ApplicationRecord
  belongs_to :user
  validates :user, presence: true
  validates :quiz_certification, presence: true
  # validates :record_police, presence: true
  # validates :bank_account, presence: true
  # validates :license, presence: true, uniqueness: true
end
