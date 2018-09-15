require 'pry'
require 'CSV'
require 'time'
require_relative 'transaction'
require_relative 'modules/find_module'

class TransactionRepository
  include FindObjects
  attr_reader :storage

  def initialize(filepath)
    @storage = []
    load_invoices(filepath)
    @object_class = Transaction
  end

  def inspect
    "#<#{self.class} #{@storage.size} rows>"
  end

  def load_invoices(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |row|
      @storage << Transaction.new(row)
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    @storage.find_all do |transaction|
      transaction.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    @storage.find_all do |transaction|
      transaction.result == result
    end
  end

  def update(id, attributes)
    transaction = find_by_id(id)
    no_card = attributes[:credit_card_number].nil?
    no_date = attributes[:credit_card_expiration_date].nil?
    no_result = attributes[:result].nil?

    transaction.credit_card_number = attributes[:credit_card_number] unless no_card
    transaction.credit_card_expiration_date = attributes[:credit_card_expiration_date] unless no_date
    transaction.result = attributes[:result] unless no_result
    transaction.updated_at = Time.now unless no_card && no_date && no_result
    transaction
  end
end
