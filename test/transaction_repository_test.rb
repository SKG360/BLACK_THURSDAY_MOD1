require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require 'time'
require './lib/transaction'
require './lib/transaction_repository'
require './lib/sales_engine'

class TransactionRepositoryTest < Minitest::Test
  def test_if_it_exists
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv"
    })

    assert_instance_of TransactionRepository, se.transactions
  end

  def test_that_it_returns_all_transactions
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
    })

    transaction = se.transactions
    assert_equal 4985, transaction.all.count
  end

  def test_it_can_find_by_id
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
    })

    transaction = se.transactions
    actual = transaction.find_by_id(2)
    assert_equal 2, actual.id
    assert_instance_of Transaction, actual
  end

  def test_it_can_find_all_by_invoice_id
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
    })

    transaction = se.transactions
    actual = transaction.find_all_by_invoice_id(2179)
    assert_equal 2, actual.count
    assert_equal [], transaction.find_all_by_invoice_id(76726)
  end

  def test_it_can_find_all_by_credit_card_number
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
    })

    transaction = se.transactions
    credit_card_number = '4848466917766329'
    credit_card_number_2 = '4848466917766328'
    actual_1 = transaction.find_all_by_credit_card_number(credit_card_number).count
    assert_equal 1, actual_1
    assert_equal [], transaction.find_all_by_credit_card_number(credit_card_number_2)
  end

  def test_it_can_find_all_by_result
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
    })

    transaction = se.transactions
    assert_equal 4158, transaction.find_all_by_result(:success).count
    assert_equal 827, transaction.find_all_by_result(:failed).count
  end

  def test_it_can_create_transactions
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
    })

    transaction = se.transactions

    attributes = {
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    }

    transaction.create(attributes)
    assert_equal 8, transaction.storage[-1].invoice_id
  end

  def test_it_can_update_transaction
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
    })

    transaction = se.transactions
    attributes = {
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    }

    transaction.create(attributes)

    attributes_2 = {result: :failed, invoice_id: 45543}

    transaction.update(4986, attributes_2)
    assert_equal 8, transaction.storage[-1].invoice_id
    assert_equal :failed, transaction.storage[-1].result
    refute_equal transaction.storage[-1].updated_at, transaction.storage[-1].created_at
  end

  def test_it_can_delete
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv"
    })

    transaction = se.transactions
    attributes = {
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    }

    transaction.create(attributes)
    transaction.delete(4986)
    assert_nil transaction.find_by_id(4986)
    
  end


end
