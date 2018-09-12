require_relative 'item_repository'
require_relative 'merchant_repository'

class SalesEngine
  attr_reader :items, :merchants

  def initialize(items, merchants)
    @items = items
    @merchants = merchants
  end

  def self.from_csv(hash_arg)
    items = ItemRepository.new(hash_arg[:items])
    merchants = MerchantRepository.new(hash_arg[:merchants])
    SalesEngine.new(items, merchants)
  end

end
