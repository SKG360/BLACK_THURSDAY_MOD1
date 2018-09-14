require 'pry'
require 'CSV'
require 'time'
require_relative 'invoice'
require_relative 'find_module'

class InvoiceRepository
  include FindObjects
  attr_accessor :invoices

  def initialize(filepath)
    @invoices = []
    @storage = @invoices
    load_invoices(filepath)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def load_invoices(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
    @invoices << Invoice.new(row)
    end
  end

  def all
    @invoices
  end

  def find_all_by_customer_id(customer_id)
    @invoices.find_all do |invoice|
      invoice.customer_id.to_i == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.find_all do |invoice|
      invoice.merchant_id.to_i == merchant_id
    end
  end

  def find_all_by_status(status)
    @invoices.find_all do |invoice|
      invoice.status == status
    end
  end

  def create(attributes)
    attributes[:id] = @invoices[-1].id + 1
    @invoices << Invoice.new(attributes)
  end



end
