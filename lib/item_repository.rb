require 'CSV'
require_relative 'item'

class ItemRepository
  attr_reader :ir

  def initialize(filepath)
    @ir = []
    load_items(filepath)
  end

  def load_items(filepath)
    data = CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
    @ir << Item.new(row)
    end

  end

  def all
    @ir
  end

  def find_by_id(id)
    @ir.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @ir.find do |item|
      item.name == name
    end
  end

  def find_all_with_description(description)
    @ir.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @ir.find_all do |item|
      item.unit_price.to_i == price
    end
  end

  def find_all_by_price_in_range(range)
    range_agg = @ir.find_all do |item|
      if (range).include?(item.unit_price.to_i/100)
        item
      end
    end
    range_agg.length
  end

  def find_all_by_merchant_id(merchant_id)
    found_merchants = @ir.find_all do |item|
      item.merchant_id == merchant_id
    end
    found_merchants.length
  end

  def create(attributes)
    attributes[:id] = @ir[-1].id + 1
    @ir << Item.new(attributes)
  end

  def update(id, attributes)
    @ir.find do |item|
      if item.id == id
      item.name = attributes[:name]
      item.description = attributes[:description]
      item.unit_price = attributes[:unit_price].to_f
      end
    end
  end

end
