require 'CSV'
require_relative 'merchant'
require_relative 'find_module'

class MerchantRepository
  include FindObjects
  attr_accessor :merchants

  def initialize(filepath)
    @merchants = []
    load_merchants(filepath)
    @storage = @merchants
  end

  def inspect
      "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    @merchants
  end

  def load_merchants(filepath)
    data = CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      @merchants << Merchant.new(row)
    end
  end

#  def find_by_id(id)
#    @merchants.find do |merchant|
#      merchant.id == id
#    end
#  end

#  def find_by_name(name)
#    @merchants.find do |merchant|
#      merchant.name.downcase == name.downcase
#    end
#  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    attributes[:id] = @merchants[-1].id + 1
    @merchants << Merchant.new(attributes)
  end

  def update(id, attributes)
    @merchants.find do |merchant|
      if merchant.id == id
        merchant.name = attributes[:name]
      else
      end
    end
  end

#  def delete(id)
#    merchant_to_delete = find_by_id(id)
#    @merchants.delete(merchant_to_delete)
#  end
end
