class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  has_many :reminders, dependent: :destroy

  validates :email, uniqueness: true, presence: true
end
