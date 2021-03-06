require 'CSV'
require 'Time'
require_relative 'item'
require_relative 'modules/find_module'

class ItemRepository
  include FindObjects
  attr_reader :storage

  def initialize(filepath)
    @storage = []
    load_items(filepath)
    @object_class = Item
  end

  def inspect
    "#<#{self.class} #{@storage.size} rows>"
  end

  def load_items(filepath)
    data = CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      @storage << Item.new(row)
    end
  end

  def find_all_with_description(description)
    @storage.find_all do |item|
      item.description.downcase.include?(description.downcase)
    end
  end

  def find_all_by_price(price)
    @storage.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_by_price_in_range(range)
    @storage.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def update(id, attributes)
    item = find_by_id(id)
    no_name = attributes[:name].nil?
    no_description = attributes[:description].nil?
    no_unit_price = attributes[:unit_price].nil?
    item.name = attributes[:name] unless no_name
    item.description = attributes[:description] unless no_description
    item.unit_price = attributes[:unit_price].to_f unless no_unit_price
    item.updated_at = Time.now unless no_name && no_description && no_unit_price
    item
  end
end
