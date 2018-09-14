require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require 'time'
require './lib/invoice'
require './lib/invoice_repository'
require './lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test
  def test_if_it_exists
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv"})

    assert_instance_of InvoiceRepository, se.invoices
  end

  def test_it_has_all_the_invoices
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv"})

    invoice = se.invoices

    assert_instance_of Array, invoice.all
  end

  def test_it_can_find_by_id
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv"})

    assert_nil  se.invoices.find_by_id(5678)
    assert_equal 21, se.invoices.find_by_id(100).customer_id
    assert_instance_of Invoice, se.invoices.find_by_id(100)
  end

  def test_it_can_find_all_by_customer_id
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv"})

    assert_equal 10, se.invoices.find_all_by_customer_id(300).count
    assert_equal [], se.invoices.find_all_by_customer_id(678987)
  end
end
