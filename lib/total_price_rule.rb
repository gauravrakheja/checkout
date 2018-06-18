class TotalPriceRule < PromotionalRule
  attr_reader :minimum_amount, :discount

  def initialize(minimum_amount, discount)
    @minimum_amount = minimum_amount
    @discount = discount
  end

  def applicable?(checkout)
    checkout.total_without_offers > minimum_amount
  end

  def apply(checkout, total)
    total -= total*discount/100.00
    total
  end
end