# == Schema Information
#
# Table name: averages
#
#  kind      :integer
#  key       :string
#  usd_sum   :float            default(0.0)
#  usd_count :integer          default(0)
#  gbp_sum   :float            default(0.0)
#  gbp_count :integer          default(0)
#  eur_sum   :float            default(0.0)
#  eur_count :integer          default(0)
#
# Indexes
#
#  index_averages_on_kind_and_key  (kind,key) UNIQUE
#
require 'rails_helper'

RSpec.describe Average, type: :model do
  it { should define_enum_for(:kind) }

  describe 'keeping averages cached' do
    before { Timecop.travel(2019, 1, 1, 12, 0, 0) }
    after { Timecop.return }

    let(:exchange_log) { ExchangeLog.create!(attributes_for(:exchange_log, updated: Time.current)) }
    let(:exchange_log_same_day) { ExchangeLog.create!(attributes_for(:exchange_log_higher, updated: Time.current + 2.hours)) }
    let(:exchange_log_same_hour) { ExchangeLog.create!(attributes_for(:exchange_log_higher, updated: Time.current + 45.minutes)) }
    let(:exchange_log_same_minute) { ExchangeLog.create!(attributes_for(:exchange_log_higher, updated: Time.current + 45.seconds)) }

    context 'adding exchange for first time' do
      it 'day average is equal to added' do
        Average.add_exchange(exchange_log)
        subject = Average.by_day(exchange_log.updated)
        expect(subject.usd_rate).to eq exchange_log.usd_rate
      end
      it 'hour average is equal to added' do
        Average.add_exchange(exchange_log)
        subject = Average.by_hour(exchange_log.updated)
        expect(subject.usd_rate).to eq exchange_log.usd_rate
      end
      it 'minute average is equal to added' do
        Average.add_exchange(exchange_log)
        subject = Average.by_minute(exchange_log.updated)
        expect(subject.usd_rate).to eq exchange_log.usd_rate
      end
    end

    context 'two exchanges in a day' do
      before do
        Average.add_exchange(exchange_log)
        Average.add_exchange(exchange_log_same_day)
      end
      it 'usd day average is calculated' do
        subject = Average.by_day(exchange_log.updated)
        expect(subject.usd_rate).to eq (exchange_log.usd_rate + exchange_log_same_day.usd_rate).fdiv 2
      end
      it 'gbp day average is calculated' do
        subject = Average.by_day(exchange_log.updated)
        expect(subject.gbp_rate).to eq (exchange_log.gbp_rate + exchange_log_same_day.gbp_rate).fdiv 2
      end
      it 'eur day average is calculated' do
        subject = Average.by_day(exchange_log.updated)
        expect(subject.eur_rate).to eq (exchange_log.eur_rate + exchange_log_same_day.eur_rate).fdiv 2
      end
    end

    context 'two exchanges in a hour' do
      before do
        Average.add_exchange(exchange_log)
        Average.add_exchange(exchange_log_same_hour)
      end
      it 'usd hour average is calculated' do
        subject = Average.by_hour(exchange_log.updated)
        expect(subject.usd_rate).to eq (exchange_log.usd_rate + exchange_log_same_hour.usd_rate).fdiv 2
      end
      it 'gbp hour average is calculated' do
        subject = Average.by_hour(exchange_log.updated)
        expect(subject.gbp_rate).to eq (exchange_log.gbp_rate + exchange_log_same_hour.gbp_rate).fdiv 2
      end
      it 'eur hour average is calculated' do
        subject = Average.by_hour(exchange_log.updated)
        expect(subject.eur_rate).to eq (exchange_log.eur_rate + exchange_log_same_hour.eur_rate).fdiv 2
      end
    end

    context 'two exchanges in a minute' do
      before do
        Average.add_exchange(exchange_log)
        Average.add_exchange(exchange_log_same_minute)
      end
      it 'usd minute average is calculated' do
        subject = Average.by_minute(exchange_log.updated)
        expect(subject.usd_rate).to eq (exchange_log.usd_rate + exchange_log_same_minute.usd_rate).fdiv 2
      end
      it 'gbp minute average is calculated' do
        subject = Average.by_minute(exchange_log.updated)
        expect(subject.gbp_rate).to eq (exchange_log.gbp_rate + exchange_log_same_minute.gbp_rate).fdiv 2
      end
      it 'eur minute average is calculated' do
        subject = Average.by_minute(exchange_log.updated)
        expect(subject.eur_rate).to eq (exchange_log.eur_rate + exchange_log_same_minute.eur_rate).fdiv 2
      end
    end
  end
end
