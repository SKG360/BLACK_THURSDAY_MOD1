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
    load_invoices(filepath)
    @storage = @invoices
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
end
