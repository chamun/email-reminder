class RemindersController < ApplicationController
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

  private

  def reminder_params
    params
      .require(:reminder)
      .permit(:title, :date)
      .tap do |reminder|
        reminder[:date] = to_date(reminder[:date])
      end
  end

  def to_date(date_string)
    Date.strptime(date_string, '%m/%d/%Y')
  end
end
