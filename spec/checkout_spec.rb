require 'spec_helper'

RSpec.describe Checkout do
  let(:item) { double(:item, product_code: "code", price: 10.0) }
  let(:rule) { double(:rule) }
  let(:subject) { described_class.new([rule]) }

  describe '#scan' do
    context 'when item did not exist' do
      it 'should create a new line item' do
        expect(subject.line_items).to eq []
        subject.scan(item)
        expect(subject.line_items.first.product_code).to eq item.product_code
      end
    end

    context 'when item already existed' do
      it 'should add/increment the line item' do
        subject.scan(item)
        subject.scan(item)
        expect(subject.line_items.first.quantity).to eq 2
      end
    end
  end

  describe '#total' do
    let(:rule) { double(:rule, applicable?: true) }
    let(:subject_with_rule) { described_class.new([rule]) }

    before do
      allow(rule).to receive(:apply) do |total|
        total + 10
      end
      subject_with_rule.scan(item)
      subject_with_rule.scan(item)
    end

    it 'should apply all the rules and give the total' do
      expect(subject_with_rule.total).to eq 2*10.00+10
    end
  end

  describe '#quantity_for' do
    let(:another_item) { double(:item, product_code: "another_code", price: 5.00) }

    before do
      subject.scan(item)
    end

    it 'should give the quantity of the item' do
      expect(subject.quantity_for(item)).to eq 1
      expect(subject.quantity_for(another_item)).to eq 0
    end
  end

  describe '#items' do
    let(:another_item) { double(:item, product_code: "another_code") }

    before do
      subject.scan(item)
      subject.scan(another_item)
    end

    it 'should give all the items' do
      expect(subject.items).to include(item, another_item)
    end
  end

  describe '#total_without_offers' do
    before do
      subject.scan(item)
      subject.scan(item)
    end

    it 'should give the total value of the item prices' do
      expect(subject.total_without_offers).to eq 2*10.0
    end
  end
end