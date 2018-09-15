require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require 'time'
require './lib/invoice_item'
require './lib/invoice_item_repository'
require './lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test
  def test_if_it_exists
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv"
    })

    assert_instance_of InvoiceItemRepository, se.invoice_items
  end
end
