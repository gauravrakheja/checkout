require 'spec_helper'

RSpec.describe MultipleItemsRule do
  let(:item) { double(:item, price: 10.0, product_code: "some_code") }
  let(:subject) { described_class.new(2, item, 5) }

  describe '#price_validation' do
    it 'raises error when new price is more than item price' do
      expect{ described_class.new(1, item, 20.00) }.to raise_exception RuntimeError
    end
  end

  describe '#applicable' do
    context 'when checkout has minimum amount of items' do
      let(:checkout) { double(:checkout, quantity_for: 2) }
      
      it 'should return true' do
        expect(subject.applicable?(checkout)).to eq true
      end
    end

    context 'when checkout does not have minimum amount of items' do
      let(:checkout) { double(:checkout, quantity_for: 1) }

      it 'should return true' do
        expect(subject.applicable?(checkout)).to eq false
      end
    end
  end

  describe '#apply' do
    let(:line_item) { double(:line_item, product_code: item.product_code, quantity: 2) }
    let(:checkout) { double(:checkout, line_items: [line_item]) }

    it 'should subtract the product prices and add the new prices' do
      expect(subject.apply(checkout, 20.00)).to eq 10.00
    end
  end
end