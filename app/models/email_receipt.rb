class EmailReceipt < ApplicationRecord
  belongs_to :subscriber
  belongs_to :comic
  belongs_to :subscription

  validates :subscriber, presence: true
  validates :comic, presence: true
  validates :subscription, presence: true
end
