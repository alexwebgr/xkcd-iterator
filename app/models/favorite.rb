class Favorite < ApplicationRecord
  belongs_to :subscriber
  belongs_to :comic

  validates :subscriber, presence: true
  validates :comic, presence: true, uniqueness: { scope: :subscriber }
end
