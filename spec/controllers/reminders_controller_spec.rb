require 'rails_helper'

RSpec.describe RemindersController, type: :controller do

  describe 'GET /new' do
    it 'returns OK' do
      expect(get :new).to be_ok
    end
  end

  describe 'POST /create' do
    it 'redirects to the /new page' do
      post :create
      expect(response).to redirect_to(new_reminder_path)
    end

    it 'creates a new reminder' do
      expect { post :create }.to change { Reminder.count }.by(1)
    end
  end

end
