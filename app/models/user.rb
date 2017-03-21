class User < ApplicationRecord
  has_many :reminders

  validates :email, uniqueness: true, presence: true
end
