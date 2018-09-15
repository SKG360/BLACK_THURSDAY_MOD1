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

  def find_all_by_item_id(item_id)
    @storage.find_all do |item|
      item.item_id == item_id
    end
  end

  def update(id, attributes)
  invoice = find_by_id(id)
  no_quantity = attributes[:quantity].nil?
  no_unit_price = attributes[:unit_price].nil?

  invoice.quantity = attributes[:quantity] unless no_quantity
  invoice.unit_price = attributes[:unit_price] unless no_unit_price
  invoice.updated_at = Time.now unless no_quantity && no_unit_price
  invoice
  end
end
