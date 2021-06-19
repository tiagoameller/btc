require 'rails_helper'

RSpec.describe Stats::MinMax, type: :model do
  describe 'keeping averages cached' do
    before { Timecop.travel(2019, 1, 1, 12, 0, 0) }
    after { Timecop.return }

    let(:exchange_log) { ExchangeLog.create!(attributes_for(:exchange_log, updated: Time.current)) }
    let(:exchange_log_same_day) { ExchangeLog.create!(attributes_for(:exchange_log_higher, updated: Time.current + 2.hours)) }
    let(:exchange_log_same_hour) { ExchangeLog.create!(attributes_for(:exchange_log_higher, updated: Time.current + 45.minutes)) }
    let(:exchange_log_same_minute) { ExchangeLog.create!(attributes_for(:exchange_log_higher, updated: Time.current + 45.seconds)) }

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
