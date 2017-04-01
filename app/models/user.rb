class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable

  has_many :reminders

  validates :email, uniqueness: true, presence: true
end
