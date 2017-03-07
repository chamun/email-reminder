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
    return unless date_and_time_are_present
    if due_date < DateTime.current
      if time_in_the_past?
        errors.add(:time, "can't be in the past")
      else
        errors.add(:date, "can't be in the past")
      end
    end
  end

  def time_in_the_past?
    (DateTime.current - due_date).round < 1
  end

  def date_and_time_are_present
    [:time, :date].all? { |key| errors[key].empty? }
  end

  def due_date
    @due_date ||= DateTime.new(date.year, date.month, date.day, time, 0, 0)
  end
end
