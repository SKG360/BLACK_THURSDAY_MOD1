require 'pry'
require 'CSV'
require 'time'
require_relative 'customer'
require_relative 'modules/find_module'

class CustomerRepository
  include FindObjects
  attr_reader :storage

  def initialize(filepath)
    @storage = []
    load_invoices(filepath)
    @object_class = Customer
  end

  def inspect
    "#<#{self.class} #{@storage.size} rows>"
  end

  def load_invoices(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      @storage << Customer.new(row)
    end
  end

  def find_all_by_first_name(fragment)
    @storage.find_all do |customer|
      customer.first_name.downcase.include?(fragment.downcase)
    end
  end

  def find_all_by_last_name(fragment)
    @storage.find_all do |customer|
      customer.last_name.downcase.include?(fragment.downcase)
    end
  end

  def update(id, attributes)
    customer = find_by_id(id)
    no_first = attributes[:first_name].nil?
    no_last = attributes[:last_name].nil?
    customer.first_name = attributes[:first_name] unless no_first
    customer.last_name = attributes[:last_name] unless no_last
    customer.updated_at = Time.now unless no_first && no_last
    customer  
  end
end
