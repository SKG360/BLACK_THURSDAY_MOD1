require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require 'time'
require './lib/item'
require './lib/item_repository'
require './lib/merchant'
require './lib/merchant_repository'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesEngineTest < Minitest::Test
  def test_if_it_exists
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    assert_instance_of SalesEngine, se
  end

  def test_it_returns_an_instance_of_merchant_repo
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    mr = se.merchants
    assert_instance_of MerchantRepository, mr
  end

  def test_it_returns_an_instance_of_item_repo
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    ir = se.items
    assert_instance_of ItemRepository, ir
  end

  def test_sales_engine_creates_sale_analyst
    sales_engine = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    assert_instance_of SalesAnalyst, sales_engine.analyst
  end
end
