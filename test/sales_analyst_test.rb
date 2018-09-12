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
end
