class Reminder < ApplicationRecord
  validates :title, presence: true
  validates :time, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than: 24
  }
  validate :current_date_and_time

  private

  def current_date_and_time
    errors.add(:date, "can't be blank") if date.nil?
    errors.add(:time, "can't be blank") if time.nil?
    if [:time, :date].all? { |key| errors[key].empty? }
      if self.date < Date.current
        errors.add(:date, "can't be in the past")
      elsif time.next % 24 < Time.current.hour.next % 24
        errors.add(:time, "can't be in the past")
      end
    end
  end
end
