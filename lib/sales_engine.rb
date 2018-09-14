require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices

  def initialize(hash)
    @items = hash[:item]
    @merchants = hash[:merchant]
    @invoices = hash[:invoice]
  end

  def self.from_csv(hash_arg)
    SalesEngine.new({:item => ItemRepository.new(hash_arg[:items]),
                     :merchant => MerchantRepository.new(hash_arg[:merchants]),
                     :invoice => InvoiceRepository.new(hash_arg[:invoices])})
  end

  def analyst
    SalesAnalyst.new(self)
  end

end
