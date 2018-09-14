require 'simplecov'
SimpleCov.start
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

  def test_it_can_find_all_by_merchant_id
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv"})

    assert_equal 7, se.invoices.find_all_by_merchant_id(12335080).count
    assert_equal [], se.invoices.find_all_by_merchant_id(7654323)
  end

  def test_it_can_find_all_by_status
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv"})

    assert_equal 2839, se.invoices.find_all_by_status(:shipped).count
    assert_equal 1473, se.invoices.find_all_by_status(:pending).count
    assert_equal [], se.invoices.find_all_by_status(:sold)
  end

  def test_it_creates_a_new_invoice
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv"})

    attributes = {
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }
    se.invoices.create(attributes)
    assert_equal 4986, se.invoices.all[-1].id
    assert_equal 7, se.invoices.all[-1].customer_id
  end

  def test_it_can_update_an_invoice
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv"})

    attributes = {
      status: :success,
      merchant_id: 56787
    }

    se.invoices.update(5, attributes)
    actual = se.invoices.find_by_id(5)
    assert_equal :success, actual.status
    assert_equal 12335311, actual.merchant_id
  end


end
