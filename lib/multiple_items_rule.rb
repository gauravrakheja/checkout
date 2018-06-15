class MultipleItemsRule < PromotionalRule
  attr_reader :minimum_quantity, :item, :new_price

  def initialize(quantity, item, price)
    @minimum_quantity = quantity
    @item = item
    @new_price = price
    validate_price
  end

  def applicable?(checkout)
    checkout.quantity_for(item) >= minimum_quantity
  end

  # modifies the current total amount
  def apply(checkout, total)
    checkout.line_items.each do |checkout_item|
      if checkout_item.product_code == item.product_code
        total -= checkout_item.quantity*item.price
        total += checkout_item.quantity*new_price
      end
    end
    total
  end

  private

  def validate_price
    raise "Offer Price cannot be greater than current price" unless item.price >= new_price
  end
end