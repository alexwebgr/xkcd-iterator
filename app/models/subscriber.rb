class Subscriber < ApplicationRecord
  before_create :create_salt_digest

  validates :email, presence: true, uniqueness: true
  validates :firstname, presence: true

  has_many :favorites, dependent: :destroy
  has_many :email_receipts, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  scope :verified, -> { where(verified: true) }

  # Returns the hash digest of the given string.
  def digest
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(SecureRandom.urlsafe_base64, cost: cost)
  end

  def create_salt_digest
    self.token = digest
  end

  def self.send_access_token_email(subscriber)
    ActivateSubscriptionMailer.do_send(subscriber).deliver_later
  end
end
