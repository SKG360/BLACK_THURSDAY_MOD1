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
    :invoices => "./data/invoices.csv"})

    assert_instance_of InvoiceRepository, se.invoices
  end

  def test_it_has_all_the_invoices
    se = SalesEngine.from_csv({
    :invoices => "./data/invoices.csv"})

    invoice = se.invoices

    assert_instance_of Array, invoices.all
  end

  def test_it_can_find_by_id
    skip
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./test/abridged_list/invoice_items_truncated.csv"})

    assert_instance_of Invoice, se.invoices.find_by_id(100)
  end
end
