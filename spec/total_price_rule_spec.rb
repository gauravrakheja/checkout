require 'spec_helper'

RSpec.describe TotalPriceRule do
  let(:subject) { described_class.new(20.00, 25) }

  describe '#applicable?' do
    context 'when total price is less than minimum amount' do
      let(:checkout) { double(:checkout, total_without_offers: 10.00) }

      it 'should return false' do
        expect(subject.applicable?(checkout)).to eq false
      end
    end

    context 'when total price is more than maximum amount' do
      let(:checkout) { double(:checkout, total_without_offers: 100.00) }

      it 'should return true' do
        expect(subject.applicable?(checkout)).to eq true
      end
    end
  end
end