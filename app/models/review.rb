class Review < ApplicationRecord
  belongs_to :ride
  validates :content, presence: true
  validates :rating, presence: true
end
