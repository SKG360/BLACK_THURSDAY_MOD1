require 'CSV'

class ItemRepository
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
end
