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
    })

    assert_instance_of SalesAnalyst, sales_engine.analyst
  end

  def test_it_returns_all_merchants
    sales_engine = SalesEngine.from_csv({
    :items     => "./test/abridged_list/items_truncated.csv",
    :merchants => "./test/abridged_list/merchants_truncated.csv",
    })

    sales_analyst = sales_engine.analyst
    assert_equal 21, sales_analyst.total_merchants.length
  end

  def test_it_returns_all_items
    sales_engine = SalesEngine.from_csv({
    :items     => "./test/abridged_list/items_truncated.csv",
    :merchants => "./test/abridged_list/merchants_truncated.csv",
    })

    sales_analyst = sales_engine.analyst

    assert_equal 34, sales_analyst.total_items.length
  end

  def test_that_it_returns_the_avg_item_per_merchant
    sales_engine = SalesEngine.from_csv({
    :items     => "./test/abridged_list/items_truncated.csv",
    :merchants => "./test/abridged_list/merchants_truncated.csv",
    })

    sales_analyst = sales_engine.analyst
    assert_equal 1.62, sales_analyst.average_items_per_merchant
  end

  def test_the_standard_deviation_avg_item_per_merchant
    sales_engine = SalesEngine.from_csv({
    :items     => "./test/abridged_list/items_truncated.csv",
    :merchants => "./test/abridged_list/merchants_truncated.csv",
    })

    sales_analyst = sales_engine.analyst
    expected_1 = [4.38, 1.38, -0.62, -0.62, -0.62, -0.62, 1.38, -0.62, -0.62,
                -0.62, -0.62, -0.62, -0.62, -0.62, -0.62, 0.38, 0.38, -0.62,
                -0.62, 2.38]
    assert_equal expected_1, sales_analyst.difference_from_mean

    expected_2 = [19.18, 1.9, 0.38, 0.38, 0.38, 0.38, 1.9, 0.38, 0.38, 0.38,
                0.38, 0.38, 0.38, 0.38, 0.38, 0.14, 0.14, 0.38, 0.38, 5.66]

    assert_equal expected_2, sales_analyst.differences_squared

    assert_equal 34.24, sales_analyst.sum_of_squared_differences
    assert_equal 1.04, sales_analyst.divided_sum
    assert_equal 1.02, sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_that_it_returns_the_merchants_that_sell_the_most_items
    sales_engine = SalesEngine.from_csv({
    :items     => "./test/abridged_list/items_truncated.csv",
    :merchants => "./test/abridged_list/merchants_truncated.csv",
    })

    sales_analyst = sales_engine.analyst
    assert_equal ({}), sales_analyst.total_items_per_merchant
    assert_equal [], sales_analyst.merchants_with_high_item_count
  end
end
