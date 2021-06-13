require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  context 'misc funcions' do
    describe 'format_date' do
      it 'with date' do
        expect(helper.format_date(Time.zone.today)).to eq I18n.l(Time.zone.today, format: '%a, %0d/%0m/%Y')
      end
      it 'with no date' do
        expect(helper.format_date(nil)).to eq I18n.t('common.undefined')
      end
    end
    describe 'format_date_time_for_sort' do
      it 'with date' do
        expect(helper.format_date_time_for_sort(
                 Time.zone.today)).to eq I18n.l(Time.zone.today, format: '%Y%0m%0d' + '000000') # rubocop:disable Style/StringConcatenation
      end
      it 'with date and time' do
        expect(helper.format_date_time_for_sort(
                 Time.zone.now)).to eq I18n.l(Time.zone.now, format: '%Y%0m%0d%H%M%S')
      end
      it 'with no date' do
        expect(helper.format_date_time_for_sort(nil)).to eq 99_999_999_999_999
      end
    end
    describe 'format_date_time' do
      it 'with date' do
        expect(helper.format_date_time(
                 Time.zone.today)).to eq I18n.l(Time.zone.today, format: '%0d/%0m/%Y' + ' 00:00') # rubocop:disable Style/StringConcatenation
      end
      it 'with date and time' do
        expect(helper.format_date_time(
                 Time.zone.now)).to eq I18n.l(Time.zone.now, format: '%0d/%0m/%Y %H:%M')
      end
      it 'with no date' do
        expect(helper.format_date_time(nil)).to eq I18n.t('common.undefined')
      end
    end
    describe 'number_to_currency_no_unit' do
      it 'removes currency' do
        expect(number_to_currency_no_unit(12_345.67)).to eq '12.345,67'
      end
    end

    describe 'blank when zero' do
      it 'retun nil if 0' do
        expect(bwz(0)).to be nil
      end
      it 'retun nil if nil' do
        expect(bwz(nil)).to be nil
      end
      it 'retun nil if NaN' do
        expect(bwz('text')).to eq 'text'
      end
      it 'retun number if is number' do
        expect(bwz(1)).to eq 1
      end
      it 'retun number if is a float' do
        expect(bwz(123.45)).to eq 123.45
      end
      describe 'number_to_currency_bwz' do
        it 'valid number' do
          expect(helper.number_to_currency_bwz(123.4)).to eq helper.number_to_currency(123.4)
        end
        it 'zero' do
          expect(helper.number_to_currency_bwz(0)).to eq '-'
        end
        it 'nil' do
          expect(helper.number_to_currency_bwz(nil)).to eq '-'
        end
      end
    end
  end

  describe 'safe_time_ago_in_words' do
    context 'when nil' do
      it 'returns never' do
        expect(helper.safe_time_ago_in_words(nil)).to eq I18n.t('common.never')
      end
    end
  end

  describe 'icons' do
    context 'concrete icon' do
      it 'returns content tag' do
        expect(coreui_icon_l('boh')).to eq '<i class="cil-boh"></i>'
      end
    end
    context 'icon with extra attributes' do
      it 'returns content tag' do
        expect(coreui_icon_l('boh', id: 'extra')).to eq '<i id="extra" class="cil-boh"></i>'
      end
    end
  end
end
