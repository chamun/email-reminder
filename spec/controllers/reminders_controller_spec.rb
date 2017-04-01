require 'rails_helper'

RSpec.describe RemindersController, type: :controller do

  let!(:user) { create(:user) }

  before do
    sign_in(user)
  end

  shared_context 'for a unauthenticated user' do
    before do
      sign_out(user)
    end

    it 'redirects to the login page' do
      expect(make_request).to redirect_to(new_user_session_url)
    end
  end

  describe 'GET /new' do
    it 'returns OK' do
      expect(get :new).to be_ok
    end

    describe 'when user is not logged in' do
      def make_request
        get :new
      end

      include_context 'for a unauthenticated user'
    end
  end

  describe 'POST /create' do

    def reminder_attributes(opts={})
      reminder = attributes_for(:reminder, opts)
      reminder.merge({
        date: reminder[:due_date],
        time: reminder[:due_date].hour
      })
    end

    shared_examples_for 'an action that creates a reminder' do
      describe 'when user is not logged in' do
        include_context 'for a unauthenticated user'

        it 'does not create a new reminder' do
          expect{ make_request }.not_to change { Reminder.count }
        end
      end
    end

    describe 'with valid params' do
      def make_request
        post :create, params: { reminder: reminder_attributes }
      end

      it_behaves_like 'an action that creates a reminder'

      it 'redirects to the /new page' do
        make_request
        expect(response).to redirect_to(new_reminder_path)
      end

      it 'creates a new reminder' do
        expect { make_request }.to change { Reminder.count }.by(1)
      end

      it 'associates the new reminder with the first user in the database' do
        make_request
        expect(Reminder.last.user).to eq(User.first)
      end
    end

    describe 'with invalid params' do
      shared_examples_for 'invalid params' do
        def make_request
          post :create, params: { reminder: reminder }
        end

        it_behaves_like 'an action that creates a reminder'

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
        let(:reminder) { reminder_attributes.merge(title: nil) }
        include_examples 'invalid params'
      end

      describe 'missing date' do
        let(:reminder) { reminder_attributes.merge(date: nil) }
        include_examples 'invalid params'
      end

      describe 'invalid date' do
        let(:reminder) { reminder_attributes.merge(date: 'invalid') }
        include_examples 'invalid params'
      end

      describe 'missing time' do
        let(:reminder) { reminder_attributes.merge(time: nil) }
        include_examples 'invalid params'
      end

      describe 'missing time' do
        let(:reminder) { reminder_attributes.merge(time: 'invalid') }
        include_examples 'invalid params'
      end
    end
  end
end
