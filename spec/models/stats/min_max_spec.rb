require 'rails_helper'

RSpec.describe Stats::MinMax, type: :model do
  describe 'keeping averages cached' do
    before { Timecop.travel(2019, 1, 1, 12, 0, 0) }
    after { Timecop.return }

    let(:exchange_log) { ExchangeLog.create!(attributes_for(:exchange_log, updated: Time.current)) }
    let(:exchange_log_same_day) { ExchangeLog.create!(attributes_for(:exchange_log_higher, updated: Time.current + 2.hours)) }
    let(:exchange_log_same_hour) { ExchangeLog.create!(attributes_for(:exchange_log_higher, updated: Time.current + 45.minutes)) }
    let(:exchange_log_same_minute) { ExchangeLog.create!(attributes_for(:exchange_log_higher, updated: Time.current + 45.seconds)) }

    # context 'adding exchange for first time' do
    #   it 'day average is equal to added' do
    #     Stats::MinMax.add_exchange(exchange_log)
    #     subject = Stats::MinMax.day(exchange_log.updated)
    #     expect(subject.usd_rate).to eq exchange_log.usd_rate
    #   end
    #   it 'hour average is equal to added' do
    #     Stats::MinMax.add_exchange(exchange_log)
    #     subject = Stats::MinMax.hour(exchange_log.updated)
    #     expect(subject.usd_rate).to eq exchange_log.usd_rate
    #   end
    #   it 'minute average is equal to added' do
    #     Stats::MinMax.add_exchange(exchange_log)
    #     subject = Stats::MinMax.minute(exchange_log.updated)
    #     expect(subject.usd_rate).to eq exchange_log.usd_rate
    #   end
    # end

    # context 'more than one exchange in a day' do
    #   before do
    #     Stats::MinMax.add_exchange(exchange_log)
    #     Stats::MinMax.add_exchange(exchange_log_same_day)
    #   end
    #   it 'usd day average is calculated' do
    #     subject = Stats::MinMax.day(exchange_log.updated)
    #     expect(subject.usd_rate).to eq (exchange_log.usd_rate + exchange_log_same_day.usd_rate).fdiv 2
    #   end
    #   it 'gbp day average is calculated' do
    #     subject = Stats::MinMax.day(exchange_log.updated)
    #     expect(subject.gbp_rate).to eq (exchange_log.gbp_rate + exchange_log_same_day.gbp_rate).fdiv 2
    #   end
    #   it 'eur day average is calculated' do
    #     subject = Stats::MinMax.day(exchange_log.updated)
    #     expect(subject.eur_rate).to eq (exchange_log.eur_rate + exchange_log_same_day.eur_rate).fdiv 2
    #   end
    # end

    # context 'more than one exchange in a hour' do
    #   before do
    #     Stats::MinMax.add_exchange(exchange_log)
    #     Stats::MinMax.add_exchange(exchange_log_same_hour)
    #   end
    #   it 'usd hour average is calculated' do
    #     subject = Stats::MinMax.hour(exchange_log.updated)
    #     expect(subject.usd_rate).to eq (exchange_log.usd_rate + exchange_log_same_hour.usd_rate).fdiv 2
    #   end
    #   it 'gbp hour average is calculated' do
    #     subject = Stats::MinMax.hour(exchange_log.updated)
    #     expect(subject.gbp_rate).to eq (exchange_log.gbp_rate + exchange_log_same_hour.gbp_rate).fdiv 2
    #   end
    #   it 'eur hour average is calculated' do
    #     subject = Stats::MinMax.hour(exchange_log.updated)
    #     expect(subject.eur_rate).to eq (exchange_log.eur_rate + exchange_log_same_hour.eur_rate).fdiv 2
    #   end
    # end

    # context 'more than one exchange in a minute' do
    #   before do
    #     Stats::MinMax.add_exchange(exchange_log)
    #     Stats::MinMax.add_exchange(exchange_log_same_minute)
    #   end
    #   it 'usd minute average is calculated' do
    #     subject = Stats::MinMax.minute(exchange_log.updated)
    #     expect(subject.usd_rate).to eq (exchange_log.usd_rate + exchange_log_same_minute.usd_rate).fdiv 2
    #   end
    #   it 'gbp minute average is calculated' do
    #     subject = Stats::MinMax.minute(exchange_log.updated)
    #     expect(subject.gbp_rate).to eq (exchange_log.gbp_rate + exchange_log_same_minute.gbp_rate).fdiv 2
    #   end
    #   it 'eur minute average is calculated' do
    #     subject = Stats::MinMax.minute(exchange_log.updated)
    #     expect(subject.eur_rate).to eq (exchange_log.eur_rate + exchange_log_same_minute.eur_rate).fdiv 2
    #   end
    # end

    context 'getting min/max with no data' do
      it 'returns null object for usd min' do
        subject = Stats::MinMax.min_usd(1.day.ago, Time.current)
        expect(subject.min).to eq 0
      end
      it 'returns null object for usd max' do
        subject = Stats::MinMax.max_usd(1.day.ago, Time.current)
        expect(subject.max).to eq 0
      end
      it 'returns null object for gbp min' do
        subject = Stats::MinMax.min_gbp(1.day.ago, Time.current)
        expect(subject.min).to eq 0
      end
      it 'returns null object for gbp max' do
        subject = Stats::MinMax.max_gbp(1.day.ago, Time.current)
        expect(subject.max).to eq 0
      end
      it 'returns null object for eur min' do
        subject = Stats::MinMax.min_eur(1.day.ago, Time.current)
        expect(subject.min).to eq 0
      end
      it 'returns null object for eur max' do
        subject = Stats::MinMax.max_eur(1.day.ago, Time.current)
        expect(subject.max).to eq 0
      end
    end
  end
end
