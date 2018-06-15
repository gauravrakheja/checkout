class Item
  attr_reader :product_code, :price, :name

  def initialize(product_code, name, price)
    @product_code = product_code
    @name = name
    @price = price
  end
end