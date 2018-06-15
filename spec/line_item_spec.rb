require 'spec_helper'

RSpec.describe LineItem do
  let(:item) { double(:item, product_code: "some_code", price: 10.0) }
  let(:subject) { described_class.new(item) }

  describe "#add" do
    it 'should increase the quantity' do
      expect(subject.quantity).to eq 1
      subject.add
      expect(subject.quantity).to eq 2
    end
  end

  describe '#price' do
    it 'should give the product price' do
      expect(subject.price).to eq 10.0
    end
  end
end