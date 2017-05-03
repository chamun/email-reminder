class RemindersController < ApplicationController
  before_action :authenticate_user!

  def new
    @reminder = Reminder.new
  end

  def create
    @reminder = Reminder.create(reminder_params)
    if @reminder.valid?
      flash[:notice] = 'Reminder successfully created!'
      redirect_to new_reminder_path
    else
      flash[:error] = 'Reminder could not be created!'
      render 'new'
    end
  end

  def index
    @reminders = current_user.reminders
  end

  private

  def reminder_params
    {
      title: params[:reminder][:title],
      message: params[:reminder][:message],
      due_date: extract_due_date(params[:reminder]),
      user: current_user
    }
  end

  def extract_due_date(reminder)
    date_string, time_string = reminder[:date], reminder[:time]
    return nil unless date_string.present? && time_string.present?
    date = Date.strptime(date_string, '%Y-%m-%d')
    Time.zone.local(date.year, date.month, date.day, Integer(time_string))
  rescue ArgumentError
    nil
  end
end
