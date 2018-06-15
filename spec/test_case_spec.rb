require 'spec_helper'

RSpec.describe 'lets try combining the components together' do
  let!(:cheap_chair) { Item.new(001, "Very Cheap Chair", 9.25) }
  let!(:little_table) { Item.new(002, "Little table", 45.00) }
  let!(:funky_light) { Item.new(003, "Funky light", 19.95) }
  let(:sixty_pound_cart_amount_promotion) { TotalPriceRule.new(60, 10) }
  let(:two_cheap_chair_promotion) { MultipleItemsRule.new(2, cheap_chair, 8.50) }
  let(:rules) { [sixty_pound_cart_amount_promotion, two_cheap_chair_promotion] }
  let!(:checkout) { Checkout.new(rules) }

  describe 'test case 1' do
    it 'should return total as 66.78' do
      #order given is 001, 002, 003
      checkout.scan(cheap_chair)
      checkout.scan(little_table)
      checkout.scan(funky_light)
      expect(checkout.total).to eq 66.78
    end
  end

  describe 'test case 2' do
    it 'should return 36.95' do
      #order given is 001, 003, 001
      expect(checkout.total)
    end
  end
end