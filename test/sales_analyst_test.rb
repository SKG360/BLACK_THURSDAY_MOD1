require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require '../lib/sales_engine'
require '../lib/sales_analyst'

class SalesAnalystTest < MiniTest::Test
  def setup
    se = SalesEngine.from_csv({
      items:     '../test/abridged_list/items_truncated.csv',
      merchants: '../test/abridged_list/merchants_truncated.csv',
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_if_it_exists
    assert_instance_of SalesAnalyst, @sa
  end

  def test_it_returns_all_merchants
    total_merchants = @sa.merchants
    assert_equal 21, total_merchants.length
  end

  def test_it_returns_all_items
    total_items = @sa.items
    assert_equal 34, total_items.length
  end
end
