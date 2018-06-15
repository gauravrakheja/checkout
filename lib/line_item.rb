class LineItem
  attr_reader :quantity, :item

  def initialize(item, quantity=1)
    @item = item
    @quantity = quantity
  end

  def add
    @quantity += 1
  end

  def product_code
    item.product_code
  end

  def price
    item.price
  end
end