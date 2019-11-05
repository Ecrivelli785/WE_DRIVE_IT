class Choice < ApplicationRecord
  belongs_to :question
  validates :declaration, presence: true
end
