class Reminder < ApplicationRecord
  validates :title, presence: true
  validate :current_date

  private

  def current_date
    if date.nil?
      errors.add(:date, "can't be blank")
    elsif self.date < Date.current
      errors.add(:date, "can't be in the past")
    end
  end
end
