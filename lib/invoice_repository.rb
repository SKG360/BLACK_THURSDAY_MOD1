require 'pry'
require 'CSV'
require 'time'
require_relative 'invoice'
require_relative 'modules/find_module'

class InvoiceRepository
  include FindObjects
  attr_reader :storage

  def initialize(filepath)
    @storage = []
    load_invoices(filepath)
    @object_class = Invoice
  end

  def inspect
    "#<#{self.class} #{@storage.size} rows>"
  end

  def load_invoices(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      @storage << Invoice.new(row)
    end
  end

  def find_all_by_customer_id(customer_id)
    @storage.find_all do |invoice|
      invoice.customer_id.to_i == customer_id
    end
  end

  def find_all_by_status(status)
    @storage.find_all do |invoice|
      invoice.status == status
    end
  end

  def update(id, attributes)
    item = find_by_id(id)
    if item.nil?
    else
      item.status = attributes[:status]
      item.updated_at = Time.now
      item
    end
  end
end
