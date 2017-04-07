require 'rails_helper'

RSpec.describe RemindersHelper, type: :helper do
  describe 'time_options' do
    it 'returns an array with available time options' do
      expect(helper.time_options).to match_array([
        ['12:00 AM', 0],
        ['01:00 AM', 1],
        ['02:00 AM', 2],
        ['03:00 AM', 3],
        ['04:00 AM', 4],
        ['05:00 AM', 5],
        ['06:00 AM', 6],
        ['07:00 AM', 7],
        ['08:00 AM', 8],
        ['09:00 AM', 9],
        ['10:00 AM', 10],
        ['11:00 AM', 11],
        ['12:00 PM', 12],
        ['01:00 PM', 13],
        ['02:00 PM', 14],
        ['03:00 PM', 15],
        ['04:00 PM', 16],
        ['05:00 PM', 17],
        ['06:00 PM', 18],
        ['07:00 PM', 19],
        ['08:00 PM', 20],
        ['09:00 PM', 21],
        ['10:00 PM', 22],
        ['11:00 PM', 23]])
    end
  end

  describe 'time_option' do
    describe 'date_time is present' do
      it 'returns a valid time option value' do
        date_time = Time.zone.local(2017, 04, 02, 22)
        expect(helper.time_option(date_time)).to eq(22)
      end
    end

    describe 'date_time is nil' do
      it 'return nil' do
        expect(helper.time_option(nil)).to be nil
      end
    end
  end

  describe 'date_value' do
    describe 'date_time is present' do
      it 'returns a valid date string' do
        date_time = Time.zone.local(2017, 04, 02, 22)
        expect(helper.date_value(date_time)).to eq('2017-04-02')
      end
    end

    describe 'date_time is nil' do
      it 'return nil' do
        expect(helper.date_value(nil)).to be nil
      end
    end
  end
end
