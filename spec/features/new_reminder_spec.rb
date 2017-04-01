require 'rails_helper'

RSpec.feature 'Creating a reminder' do

  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  def select_future_date_and_time
    future_date = DateTime.current.tomorrow
    fill_in 'Date', with: future_date
    within('#reminder_time') do
      find("option[value='#{future_date.hour}']").click
    end
  end

  scenario 'Submiting a complete form' do
    visit new_reminder_path
    fill_in 'Title', with: 'Eggs'
    select_future_date_and_time
    fill_in 'Message', with: "Don't forget to buy eggs"
    click_on 'Submit'

    expect(page).to have_content('Reminder successfully created!')
  end

  scenario 'Submiting the form without a title' do
    visit new_reminder_path
    fill_in 'Date', with: Date.current
    select '01:00 PM', from: 'Time'
    fill_in 'Message', with: "Don't forget to buy eggs"
    click_on 'Submit'

    expect(page).to have_content('Reminder could not be created!')
  end

  scenario 'Submiting the form without a date' do
    visit new_reminder_path
    fill_in 'Title', with: 'Eggs'
    select '01:00 PM', from: 'Time'
    fill_in 'Message', with: "Don't forget to buy eggs"
    click_on 'Submit'

    expect(page).to have_content('Reminder could not be created!')
  end

  scenario 'User is not logged in' do
    sign_out user
    visit new_reminder_path
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end
end
