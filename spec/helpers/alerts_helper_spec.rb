require 'rails_helper'

RSpec.describe AlertsHelper, type: :helper do
  context 'flash_messages' do
    describe 'with no flash' do
      it 'returns nil' do
        expect(helper.flash_messages).to be nil
      end
    end
  end
  context 'toast_messages' do
    describe 'with no flash' do
      it 'returns nil' do
        expect(helper.toast_messages.blank?).to be true
      end
    end
  end
end
