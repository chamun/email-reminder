require 'rails_helper'

RSpec.feature 'Creating a reminder' do

  scenario 'Submiting the form' do
    visit new_reminder_path
    fill_in 'Title', with: 'Eggs'
    fill_in 'Date', with: '12/20/1991'
    select '01:00 PM', from: 'Time'
    fill_in 'Message', with: "Don't forget to buy eggs"
    click_on 'Submit'

    expect(page).to have_content('Reminder successfully created!')
  end
end
