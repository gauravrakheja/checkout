# explicitly stating the classes it needs
# the more classes it needs to compile the more dependent this
# class will be
require_relative 'line_item'

class Checkout
  attr_reader :line_items

  def initialize(rules)
    @rules = rules
    @line_items = []
  end

  def scan(item)
    existing_item = line_item_for(item)
    unless existing_item.nil?
      existing_item.add
    else
      line_items << create_line_item_for(item)
    end
  end

  def total
    total = total_without_offers
    rules.each do |rule|
      total = rule.apply(total) if rule.applicable?(self)
    end
    total
  end

  def quantity_for(item)
    line_item = line_item_for(item)
    if line_item
      line_item.quantity
    else
      0
    end
  end

  def items
    line_items.map(&:item)
  end

  def total_without_offers
    total = 0
    line_items.each do |line_item|
      total += line_item.price*line_item.quantity
    end
    total
  end

  private
  attr_writer :line_items
  attr_reader :rules

  def line_item_for(item)
    line_items.detect {|line_item| line_item.product_code == item.product_code}
  end

  def create_line_item_for(item)
    LineItem.new(item)
  end
end