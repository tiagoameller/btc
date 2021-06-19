require 'rails_helper'

RSpec.describe Stats::Average, type: :model do
  describe 'keeping averages cached' do
    before { Timecop.travel(2019, 1, 1, 12, 0, 0) }
    after { Timecop.return }

    let(:exchange_log) { build(:exchange_log, updated: Time.current) }
    let(:exchange_log_same_day) { build(:exchange_log_higher, updated: Time.current + 2.hours) }
    let(:exchange_log_same_hour) { build(:exchange_log_higher, updated: Time.current + 45.minutes) }
    let(:exchange_log_same_minute) { build(:exchange_log_higher, updated: Time.current + 45.seconds) }

    context 'adding exchange for first time' do
      it 'day average is equal to added' do
        exchange_log.save!
        subject = Stats::Average.day(exchange_log.updated)
        expect(subject.usd_rate).to eq exchange_log.usd_rate
      end
      it 'hour average is equal to added' do
        exchange_log.save!
        subject = Stats::Average.hour(exchange_log.updated)
        expect(subject.usd_rate).to eq exchange_log.usd_rate
      end
      it 'minute average is equal to added' do
        exchange_log.save!
        subject = Stats::Average.minute(exchange_log.updated)
        expect(subject.usd_rate).to eq exchange_log.usd_rate
      end
    end

    context 'more than one exchange in a day' do
      before do
        exchange_log.save!
        exchange_log_same_day.save!
      end
      it 'usd day average is calculated' do
        subject = Stats::Average.day(exchange_log.updated)
        expect(subject.usd_rate).to eq (exchange_log.usd_rate + exchange_log_same_day.usd_rate).fdiv 2
      end
      it 'gbp day average is calculated' do
        subject = Stats::Average.day(exchange_log.updated)
        expect(subject.gbp_rate).to eq (exchange_log.gbp_rate + exchange_log_same_day.gbp_rate).fdiv 2
      end
      it 'eur day average is calculated' do
        subject = Stats::Average.day(exchange_log.updated)
        expect(subject.eur_rate).to eq (exchange_log.eur_rate + exchange_log_same_day.eur_rate).fdiv 2
      end
    end

    context 'more than one exchange in a hour' do
      before do
        exchange_log.save!
        exchange_log_same_hour.save!
      end
      it 'usd hour average is calculated' do
        subject = Stats::Average.hour(exchange_log.updated)
        expect(subject.usd_rate).to eq (exchange_log.usd_rate + exchange_log_same_hour.usd_rate).fdiv 2
      end
      it 'gbp hour average is calculated' do
        subject = Stats::Average.hour(exchange_log.updated)
        expect(subject.gbp_rate).to eq (exchange_log.gbp_rate + exchange_log_same_hour.gbp_rate).fdiv 2
      end
      it 'eur hour average is calculated' do
        subject = Stats::Average.hour(exchange_log.updated)
        expect(subject.eur_rate).to eq (exchange_log.eur_rate + exchange_log_same_hour.eur_rate).fdiv 2
      end
    end

    context 'more than one exchange in a minute' do
      before do
        exchange_log.save!
        exchange_log_same_minute.save!
      end
      it 'usd minute average is calculated' do
        subject = Stats::Average.minute(exchange_log.updated)
        expect(subject.usd_rate).to eq (exchange_log.usd_rate + exchange_log_same_minute.usd_rate).fdiv 2
      end
      it 'gbp minute average is calculated' do
        subject = Stats::Average.minute(exchange_log.updated)
        expect(subject.gbp_rate).to eq (exchange_log.gbp_rate + exchange_log_same_minute.gbp_rate).fdiv 2
      end
      it 'eur minute average is calculated' do
        subject = Stats::Average.minute(exchange_log.updated)
        expect(subject.eur_rate).to eq (exchange_log.eur_rate + exchange_log_same_minute.eur_rate).fdiv 2
      end
    end

    context 'getting average with no data' do
      it 'returns null object for day' do
        subject = Stats::Average.day(Time.current)
        expect(subject.usd_rate).to eq 0
        expect(subject.gbp_rate).to eq 0
        expect(subject.eur_rate).to eq 0
      end
      it 'returns null object for hour' do
        subject = Stats::Average.hour(Time.current)
        expect(subject.usd_rate).to eq 0
        expect(subject.gbp_rate).to eq 0
        expect(subject.eur_rate).to eq 0
      end
      it 'returns null object for minute' do
        subject = Stats::Average.minute(Time.current)
        expect(subject.usd_rate).to eq 0
        expect(subject.gbp_rate).to eq 0
        expect(subject.eur_rate).to eq 0
      end
    end
  end
end
