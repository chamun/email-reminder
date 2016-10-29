require 'rails_helper'

RSpec.describe RemindersController, type: :controller do

  describe 'GET /new' do
    it 'returns OK' do
      expect(get :new).to be_ok
    end
  end

  describe 'POST /create' do

    describe 'with valid params' do

      def make_request
        post :create, params: {
          reminder: { title: 'A title', date: '02/15/1991' }
        }
      end

      it 'redirects to the /new page' do
        make_request
        expect(response).to redirect_to(new_reminder_path)
      end

      it 'creates a new reminder' do
        expect { make_request }.to change { Reminder.count }.by(1)
      end
    end
  end

end
