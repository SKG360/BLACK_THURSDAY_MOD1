require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require 'time'
require './lib/item'
require './lib/item_repository'
require './lib/merchant'
require './lib/merchant_repository'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesEngineTest < Minitest::Test
  def test_if_it_exists
    se = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv',
      customers: './data/customers.csv'
    })

    assert_instance_of SalesEngine, se
  end

  def test_it_returns_an_instance_of_merchant_repo
    se = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv',
      customers: './data/customers.csv'
    })

    mr = se.merchants
    assert_instance_of MerchantRepository, mr
  end

  def test_it_returns_an_instance_of_item_repo
    se = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv',
      customers: './data/customers.csv'
    })

    ir = se.items
    assert_instance_of ItemRepository, ir
  end

  def test_it_returns_an_instance_of_item_repo
    se = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv',
      customers: './data/customers.csv'
    })

    invoices = se.invoices
    assert_instance_of InvoiceRepository, invoices
  end

  def test_it_returns_an_instance_of_item_repo
    se = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv',
      customers: './data/customers.csv'
    })

    invoice_items = se.invoice_items
    assert_instance_of InvoiceItemRepository, invoice_items
  end

  def test_it_returns_an_instance_of_item_repo
    se = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv',
      customers: './data/customers.csv'
    })

    transactions = se.transactions
    assert_instance_of TransactionRepository, transactions
  end

  def test_it_returns_an_instance_of_item_repo
    se = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv',
      customers: './data/customers.csv'
    })

    customer = se.customers
    assert_instance_of CustomerRepository, customer
  end

  def test_sales_engine_creates_sale_analyst
    se = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv',
      customers: './data/customers.csv'
    })

    assert_instance_of SalesAnalyst, se.analyst
  end
end
