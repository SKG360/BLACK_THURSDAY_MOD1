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
    expected_1 = [11.38, 5.38, 28.37, 8.37, 8.37, 11.38, 13.38, 148.38, 18.38,
                  33.38, 33.38, 33.38, 12.38, 13.37, 5.58, 23.38, 28.38, 11.38,
                  5.38, 28.37, 8.37, 8.37, 11.38, 13.38, 148.38, 18.38, 33.38,
                  33.38, 33.38, 12.38, 13.37, 5.58, 23.38, 28.38]
    assert_equal expected_1, sales_analyst.difference_from_mean

    expected_2 = [129.5, 28.94, 804.86, 70.06, 70.06, 129.5, 179.02, 22016.62,
                  337.82, 1114.22, 1114.22, 1114.22, 153.26, 178.76, 31.14, 546.62,
                  805.42, 129.5, 28.94, 804.86, 70.06, 70.06, 129.5, 179.02, 22016.62,
                  337.82, 1114.22, 1114.22, 1114.22, 153.26, 178.76, 31.14, 546.62, 805.42]

    assert_equal expected_2, sales_analyst.differences_squared

    assert_equal 57648.48, sales_analyst.sum_of_squared_differences
    assert_equal 1746.92, sales_analyst.divided_sum
    assert_equal 41.8, sales_analyst.average_items_per_merchant_standard_deviation
  end
end
