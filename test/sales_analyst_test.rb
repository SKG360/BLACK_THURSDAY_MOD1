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
    assert_equal 21, sales_analyst.total_merchants
  end

  def test_it_returns_all_items
    sales_engine = SalesEngine.from_csv({
    :items     => "./test/abridged_list/items_truncated.csv",
    :merchants => "./test/abridged_list/merchants_truncated.csv",
    })

    sales_analyst = sales_engine.analyst

    assert_equal 34, sales_analyst.total_items
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
    expected_1 = [-4.38, -1.38, 0.62, 0.62, 0.62, 0.62, -1.38, 0.62,
                  0.62, 0.62, 0.62, 0.62, 0.62, 0.62, 0.62, -0.38,
                  -0.38, 0.62, 0.62, -2.38]

    assert_equal expected_1, sales_analyst.difference_from_mean

    expected_2 = [19.18, 1.9, 0.38, 0.38, 0.38, 0.38, 1.9, 0.38, 0.38, 0.38,
                0.38, 0.38, 0.38, 0.38, 0.38, 0.14, 0.14, 0.38, 0.38, 5.66]

    assert_equal expected_2, sales_analyst.differences_squared

    assert_equal 34.24, sales_analyst.sum_of_squared_differences
    assert_equal 1.8, sales_analyst.divided_sum
    assert_equal 1.34, sales_analyst.average_items_per_merchant_standard_deviation
  end

  def test_that_it_returns_the_merchants_that_sell_the_most_items
    sales_engine = SalesEngine.from_csv({
    :items     => "./test/abridged_list/items_truncated.csv",
    :merchants => "./test/abridged_list/merchants_truncated.csv",
    })

    sales_analyst = sales_engine.analyst

    expected_1 = {12334185=>6, 12334105=>3, 12334609=>1, 12334112=>1, 12334113=>1,
                  12334115=>1, 12334132=>3, 12334135=>1, 12334144=>1, 12334444=>1,
                  12334145=>1, 12334149=>1, 12334155=>1, 12334159=>1, 12334160=>1,
                  12334165=>2, 12334174=>2, 12334176=>1, 12334183=>1, 12334189=>4}
    assert_equal expected_1, sales_analyst.total_items_per_merchant

    # expected_2 = [[12334185, 3.7], [12334105, 1.85], [12334132, 1.85],
    #               [12334165, 1.23], [12334174, 1.23], [12334189, 2.47]]
    # assert_equal expected_2, sales_analyst.total_items_divided_by_avg_item

    assert_equal [12334185, 12334105, 12334132, 12334189], sales_analyst.merchant_id_with_high_item_count

    assert_equal 5, sales_analyst.merchants_with_high_item_count.count
  end

  def test_the_avg_item_price_per_merchant
    skip
    sales_engine = SalesEngine.from_csv({
    :items     => "./test/abridged_list/items_truncated.csv",
    :merchants => "./test/abridged_list/merchants_truncated.csv",
    })

    sales_analyst = sales_engine.analyst

    assert_equal [13.0, 7.0, 7.2, 20.0, 14.99, 7.2], sales_analyst.array_of_merch_items(12334185)
    assert_equal 69.39, sales_analyst.sum_of_merch_items_array(12334185)
    assert_equal 11.57, sales_analyst.average_item_price_for_merchant(12334185)
  end

  def test_it_makes_array_of_avg_item_prices
    skip
    sales_engine = SalesEngine.from_csv({
    :items     => "./test/abridged_list/items_truncated.csv",
    :merchants => "./test/abridged_list/merchants_truncated.csv",
    })

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
    :items     => "./test/abridged_list/items_truncated.csv",
    :merchants => "./test/abridged_list/merchants_truncated.csv",
    })

    sales_analyst = sales_engine.analyst
    assert_equal 33.65, sales_analyst.two_standard_devs_above
    assert sales_analyst.golden_items[0], Item
    assert_equal 8, sales_analyst.golden_items.count
  end
end
