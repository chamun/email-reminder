class Reminder < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :due_date, presence: true
  validate :future_due_date

  private

  def future_due_date
    return unless due_date.present?
    if due_date < DateTime.current
      errors.add(:due_date, "can't be in the past")
    end
  end
end
