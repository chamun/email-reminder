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

    describe 'without a title params' do

      def make_request
        post :create, params: { reminder: { date: '02/15/1991' } }
      end

      it 'renders the :new template' do
        make_request
        expect(response).to render_template('new')
      end

      it 'does not create a new reminder' do
        expect { make_request }.not_to change { Reminder.count }
      end

      it 'flashes an error message' do
        make_request
        expect(flash[:error]).to eq('Reminder could not be created!')
      end
    end

    describe 'without a date param' do

      def make_request
        post :create, params: { reminder: { title: 'A title' } }
      end

      it 'renders the :new template' do
        make_request
        expect(response).to render_template('new')
      end

      it 'does not create a new reminder' do
        expect { make_request }.not_to change { Reminder.count }
      end

      it 'flashes an error message' do
        make_request
        expect(flash[:error]).to eq('Reminder could not be created!')
      end
    end

    describe 'with an invalid date' do

      def make_request
        post :create, params: { reminder: { title: 'A title', date: 'invalid' } }
      end

      it 'renders the :new template' do
        make_request
        expect(response).to render_template('new')
      end

      it 'does not create a new reminder' do
        expect { make_request }.not_to change { Reminder.count }
      end

      it 'flashes an error message' do
        make_request
        expect(flash[:error]).to eq('Reminder could not be created!')
      end
    end
  end

end
