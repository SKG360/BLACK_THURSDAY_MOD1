require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(hash)
    @items = hash[:item]
    @merchants = hash[:merchant]
    @invoices = hash[:invoice]
    @invoice_items = hash[:invoice_items]
    @transactions = hash[:transactions]
    @customers = hash[:customers]
  end

  def self.from_csv(hash_arg)
    SalesEngine.new({:item => ItemRepository.new(hash_arg[:items]),
                     :merchant => MerchantRepository.new(hash_arg[:merchants]),
                     :invoice => InvoiceRepository.new(hash_arg[:invoices]),
                     :invoice_items => InvoiceItemRepository.new(hash_arg[:invoice_items]),
                     :transactions => TransactionRepository.new(hash_arg[:transactions]),
                     :customers => CustomerRepository.new(hash_arg[:customers])
                     })
  end

  def analyst
    SalesAnalyst.new(self)
  end

end
