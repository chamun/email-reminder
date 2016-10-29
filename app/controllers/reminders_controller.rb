class RemindersController < ApplicationController
  def new
    @reminder = Reminder.new
  end

  def create
    Reminder.create!
    flash[:notice] = 'Reminder successfully created!'
    redirect_to new_reminder_path
  end
end
