require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < MiniTest::Test
  def test_if_it_exists
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"})

    assert_instance_of SalesAnalyst, sales_engine.analyst
  end

  def test_it_returns_all_merchants
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"})

    sales_analyst = sales_engine.analyst
    assert_equal 475, sales_analyst.total_merchants
  end

  def test_it_returns_all_items
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"})

    sales_analyst = sales_engine.analyst

    assert_equal 1367, sales_analyst.total_items
  end

  def test_that_it_returns_the_avg_item_per_merchant
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"})

    sales_analyst = sales_engine.analyst
    assert_equal 2.88, sales_analyst.average_items_per_merchant
  end

  def test_the_standard_deviation_avg_item_per_merchant
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"})

    sales_analyst = sales_engine.analyst

    assert_equal 3.26, sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_that_it_returns_the_merchants_that_sell_the_most_items
    sales_engine = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv"})

    sales_analyst = sales_engine.analyst

    assert_equal 475, sales_analyst.total_items_per_merchant.count

    assert_equal 52, sales_analyst.merchant_id_with_high_item_count.count

    assert_equal 52, sales_analyst.merchants_with_high_item_count.count
  end

  def test_the_avg_item_price_per_merchant
    skip
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"})

    sales_analyst = sales_engine.analyst

    assert_equal [13.0, 7.0, 7.2, 20.0, 14.99, 7.2], sales_analyst.array_of_merch_items(12334185)
    assert_equal 69.39, sales_analyst.sum_of_merch_items_array(12334185)
    assert_equal 11.57, sales_analyst.average_item_price_for_merchant(12334185)
  end

  def test_it_makes_array_of_avg_item_prices
    skip
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"})

    sales_analyst = sales_engine.analyst
    expected_1 = [16.66, 15.0, 150.0, 20.0, 35.0, 14.0, 14.99, 30.0,
                  25.0, 11.57, 13.0, 13.0, 7.0, 29.99, 9.99, 20.0, 19.0,
                  15.0, 150.0, 11.57, 29.75]
    assert_equal expected_1, sales_analyst.array_of_merchant_averages

    assert_equal 650.52, sales_analyst.sum_of_averages
    assert_equal 30.98, sales_analyst.average_average_price_per_merchant

  end

  def test_if_it_returns_an_array_of_golden_items
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"})

    sales_analyst = sales_engine.analyst
    assert_equal 6155.85, sales_analyst.two_standard_devs_above
    assert sales_analyst.golden_items[0], Item
    assert_equal 5, sales_analyst.golden_items.count
  end

  def test_it_calculates_average_invoices_per_merchant
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"})

    sales_analyst = sales_engine.analyst
    assert_equal 4985, sales_analyst.total_invoices
    assert_equal 10.49, sales_analyst.average_invoices_per_merchant.length
  end

  def test_it_calculates_average_invoices_per_merchant_standard_deviation
    sales_engine = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv"})

    sales_analyst = sales_engine.analyst
    assert_equal 4.5, sales_analyst.total_invoices_per_merchant
    assert_equal 3.29, sales_analyst.average_invoices_per_merchant_standard_deviation
  end
end
