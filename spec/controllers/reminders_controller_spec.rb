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
        post :create, params: { reminder: attributes_for(:reminder) }
      end

      it 'redirects to the /new page' do
        make_request
        expect(response).to redirect_to(new_reminder_path)
      end

      it 'creates a new reminder' do
        expect { make_request }.to change { Reminder.count }.by(1)
      end
    end

    describe 'with invalid params' do
      shared_examples_for 'invalid params' do
        def make_request
          post :create, params: { reminder: reminder }
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

      describe 'missing title' do
        let(:reminder) { attributes_for(:reminder, title: nil) }
        include_examples 'invalid params'
      end

      describe 'missing date' do
        let(:reminder) { attributes_for(:reminder, date: nil) }
        include_examples 'invalid params'
      end

      describe 'invalid date' do
        let(:reminder) { attributes_for(:reminder, date: 'invalid') }
        include_examples 'invalid params'
      end

      describe 'missing time' do
        let(:reminder) { attributes_for(:reminder, time: nil) }
        include_examples 'invalid params'
      end

      describe 'missing time' do
        let(:reminder) { attributes_for(:reminder, time: 'invalid') }
        include_examples 'invalid params'
      end
    end
  end

end
