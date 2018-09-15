require 'CSV'
require_relative 'merchant'
require_relative 'modules/find_module'

class MerchantRepository
  include FindObjects
  attr_reader :storage

  def initialize(filepath)
    @storage = []
    load_merchants(filepath)
    @object_class = Merchant
  end

  def inspect
    "#<#{self.class} #{@storage.size} rows>"
  end

  def load_merchants(filepath)
    data = CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      @storage << Merchant.new(row)
    end
  end

  def find_all_by_name(name)
    @storage.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def update(id, attributes)
    @storage.find do |merchant|
      if merchant.id == id
        merchant.name = attributes[:name]
      else
      end
    end
  end
end
