require "rails_helper"

RSpec.feature "Navigation" do

  let!(:user) { create(:user) }

  scenario "From the log in page to the forgot password page" do
    visit new_user_session_path
    click_on "Forgot your password?"
    expect(page).to have_button("Send me reset password instructions")
  end

  scenario "From the log in page to the sign up page" do
    visit new_user_session_path
    click_on "Sign up"
    expect(page).to have_button("Sign up")
  end

  scenario "From the log in page to the new reminders page" do
    visit new_user_session_path
    within("#new_user") do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_on "Log in"
    end
    expect(page).to have_button("Submit")
    expect(page).to have_text("New reminder")
  end

  scenario "From the forgot password page to log in page" do
    visit new_user_password_path
    click_on "Log in"
    expect(page).to have_button("Log in")
  end

  scenario "From the forgot password page to the signup page" do
    visit new_user_password_path
    click_on "Sign up"
    expect(page).to have_button("Sign up")
  end

  scenario "From the sign up page to the log in page" do
    visit new_user_registration_path
    click_on "Log in"
    expect(page).to have_button("Log in")
  end

  scenario "From the edit user page to the new reminder page" do
    sign_in user
    visit edit_user_registration_path
    click_on "New reminder"
    expect(page).to have_button("Submit")
    expect(page).to have_text("New reminder")
  end

  scenario "Logging out from the edit user page" do
    sign_in user
    visit edit_user_registration_path
    click_on "Log out"
    expect(page).to have_text("Signed out successfully")
  end

  scenario "From the new reminder page to edit user page" do
    sign_in user
    visit new_reminder_path
    click_on "Settings"
    expect(page).to have_text("Edit #{user.email}")
    expect(page).to have_button("Update")
  end

  scenario "From the new reminder page to list all reminders page" do
    reminder = create(:reminder, user: user)
    sign_in user
    visit new_reminder_path
    click_on "My reminders"
    expect(page).to have_text(reminder.title)
    expect(page).to have_text(reminder.due_date)
  end

  scenario "From the edit user page to list all reminders page" do
    reminder = create(:reminder, user: user)
    sign_in user
    visit edit_user_registration_path
    click_on "My reminders"
    expect(page).to have_text(reminder.title)
    expect(page).to have_text(reminder.due_date)
  end

  scenario "Logging out from the new reminder page" do
    sign_in user
    visit new_reminder_path
    click_on "Log out"
    expect(page).to have_text("Signed out successfully")
  end
end
