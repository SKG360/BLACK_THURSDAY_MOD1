require 'pry'
require 'CSV'
require 'time'
require_relative 'invoice_item'
require_relative 'modules/find_module'

class InvoiceItemRepository
  include FindObjects
  attr_reader :storage

  def initialize(filepath)
    @storage = []
    load_invoices(filepath)
    @object_class = InvoiceItem
  end

  def inspect
    "#<#{self.class} #{@storage.size} rows>"
  end

  def load_invoices(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      @storage << InvoiceItem.new(row)
    end
  end
end
