class Reminder < ApplicationRecord
  validates :title, presence: true
  validates :time, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than: 24
  }
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
