require 'rails_helper'

RSpec.feature 'Listing all reminders' do

  let!(:tom) { create(:user, email: "tom@example.com") }
  let!(:bob) { create(:user, email: "bob@example.com") }

  context "Tom has reminders" do
    before do
      create_list(
        :reminder, 5,
        user: tom,
        title: "Tom's reminder",
        due_date: DateTime.current + 1.hour
      )
      create_list(
        :reminder, 5,
        user: bob,
        title: "Bob's reminder",
        due_date: DateTime.current + 2.hours
      )
      sign_in tom
      visit reminders_path
    end

    it "list all of Tom's reminders" do
      expect(tom.reminders.size).to be > 0
      tom.reminders.each do |reminder|
        expect(page).to have_text(reminder.title)
        expect(page).to have_text(reminder.due_date)
      end
    end

    it "does not list Bob's reminders" do
      expect(bob.reminders.size).to be > 0
      bob.reminders.each do |reminder|
        expect(page).not_to have_text(reminder.title)
        expect(page).not_to have_text(reminder.due_date)
      end
    end
  end

  context "Tom does not have reminders" do
    before do
      sign_in tom
      visit reminders_path
    end

    it "shows a message stating this fact" do
      expect(tom.reminders.size).to be 0
      expect(page).to have_text("You have no reminders")
    end
  end

end
