require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require 'time'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < MiniTest::Test
  def test_if_it_exists
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    assert_instance_of SalesAnalyst, sales_engine.analyst
  end

  def test_it_returns_all_merchants
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst

    assert_equal 475, sales_analyst.total_merchants
  end

  def test_it_returns_all_items
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst

    assert_equal 1367, sales_analyst.total_items
  end

  def test_that_it_returns_the_avg_item_per_merchant
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst

    assert_equal 2.88, sales_analyst.average_items_per_merchant
  end

  def test_the_standard_deviation_avg_item_per_merchant
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst

    actual = sales_analyst.average_items_per_merchant_standard_deviation
    assert_equal 3.26, actual
  end

  def test_that_it_returns_the_merchants_that_sell_the_most_items
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst

    assert_equal 475, sales_analyst.total_items_per_merchant.count
    assert_equal 52, sales_analyst.merchant_id_with_high_item_count.count
    assert_equal 52, sales_analyst.merchants_with_high_item_count.count
  end

  def test_the_avg_item_price_per_merchant
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst

    assert_equal 64.7, sales_analyst.sum_of_merch_items_array(12334185)
    assert_equal 10.78, sales_analyst.average_item_price_for_merchant(12334185)
  end

  def test_it_makes_array_of_avg_item_prices
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst

    assert_equal 475, sales_analyst.array_of_merchant_averages.count
    assert_equal 166391.91, sales_analyst.sum_of_averages
    assert_equal 350.29, sales_analyst.average_average_price_per_merchant
  end

  def test_if_it_returns_an_array_of_golden_items
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst

    assert sales_analyst.golden_items[0], Item
    assert_equal 5, sales_analyst.golden_items.count
  end

  def test_it_calculates_average_invoices_per_merchant
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst

    assert_equal 4985, sales_analyst.total_invoices.length
    assert_equal 10.49, sales_analyst.average_invoices_per_merchant
  end

  def test_it_calculates_average_invoices_per_merchant_standard_deviation
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst

    actual = sales_analyst.average_invoices_per_merchant_standard_deviation
    assert_equal 3.29, actual
  end

  def test_it_can_find_total_invoices_per_merchant
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst

    assert_equal 475, sales_analyst.total_invoices_per_merchant.count
  end

  def test_it_can_calculate_two_standard_deviations
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst

    assert_equal 6.58, sales_analyst.two_standard_deviations
  end

  def test_it_can_return_top_merchants_merchant_ids
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst

    actual = sales_analyst.top_merchants_by_invoice_count_merchant_ids.count
    assert_equal 12, actual
  end

  def test_it_can_return_top_merchants
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst

    assert_equal 12, sales_analyst.top_merchants_by_invoice_count.count
  end

  def test_it_can_return_bottom_merchants
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst

    actual = sales_analyst.bottom_merchants_by_invoice_count_merchant_ids
    assert_instance_of Array, actual
    assert_equal 4, sales_analyst.bottom_merchants_by_invoice_count.count
  end

  def test_it_can_calculate_top_days_by_invoice_count
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst

    expected = {"Saturday"=>729, "Friday"=>701, "Wednesday"=>741,
                "Monday"=>696, "Sunday"=>708, "Tuesday"=>692, "Thursday"=>718}
    assert_equal expected, sales_analyst.total_invoices_per_day_hash
    assert_equal 712, sales_analyst.average_invoices_per_day
    assert_equal 18.07, sales_analyst.standard_deviation_of_invoices_per_day
    assert_equal ["Wednesday"], sales_analyst.top_days_by_invoice_count
  end

  def test_it_can_calculate_precantage_based_on_status
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst

    expected = {:pending=>1473, :shipped=>2839, :returned=>673}
    assert_equal expected, sales_analyst.invoice_status_hash
    assert_equal 29.55, sales_analyst.invoice_status(:pending)
    assert_equal 56.95, sales_analyst.invoice_status(:shipped)
    assert_equal 13.5, sales_analyst.invoice_status(:returned)
  end

  def test_that_the_invoice_is_paid_in_full
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst

    assert_equal true, sales_analyst.invoice_paid_in_full?(1)
    assert_equal true, sales_analyst.invoice_paid_in_full?(200)
    refute sales_analyst.invoice_paid_in_full?(203)
    refute sales_analyst.invoice_paid_in_full?(204)
  end

  def test_it_calulates_invoice_total
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst

    assert_equal 21067.77, sales_analyst.invoice_total(1)
  end

  def test_it_returns_merchants_with_only_one_item
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst
    assert_instance_of Hash, sales_analyst.group_items_by_merchant_id
    assert_equal 243, sales_analyst.hash_of_merchants_with_one_item.keys.count
    assert_equal 243, sales_analyst.merchants_with_only_one_item.count
  end

  def test_it_can_calculate_total_revenue_date
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst
    assert_equal 8, sales_analyst.finds_invoice_items_totals("2009-02-07").count
    assert_equal 8, sales_analyst.finds_invoice_items_by_date("2009-02-07").count
    assert_equal 1, sales_analyst.finds_invoices_by_date("2009-02-07").count
    assert_equal 21067.77, sales_analyst.total_revenue_by_date("2009-02-07")
  end

  def test_it_can_return_the_top_revenue_earners
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants:  "./data/merchants.csv",
      invoices:  "./data/invoices.csv",
      invoice_items:  "./data/invoice_items.csv",
      transactions:  "./data/transactions.csv",
      customers:  "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst

    #assert_instance_of Hash, sales_analyst.grouped_invoices_by_merchants
    #assert_instance_of Hash, sales_analyst.finds_grouped_invoice_ids
    #assert_instance_of Array, sales_analyst.finds_grouped_invoice_ids.values
    #assert_instance_of Hash, sales_analyst.finds_grouped_invoice_items
    #assert_instance_of Hash, sales_analyst.finds_invoice_totals
    #assert_instance_of Hash, sales_analyst.finds_pre_sorted_sums
    #assert_instance_of BigDecimal, sales_analyst.finds_pre_sorted_sums.values[0]
    assert_equal 343344, sales_analyst.sorted_merchants_by_revenue_totals
  end

  def test_it_can_find_merchants_with_pending_invoices
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst

    assert_equal 4158, sales_analyst.find_all_successful_transactions.count
    assert_equal 4158, sales_analyst.find_invoice_ids_for_successful_transactions.count
    assert_equal 2175, sales_analyst.pending_invoices.count
    assert_equal 467, sales_analyst.merchant_ids_from_pending_invoices.count
    assert_instance_of Merchant, sales_analyst.merchants_with_pending_invoices[0]
    assert_equal 467, sales_analyst.merchants_with_pending_invoices.count
  end

  def test_it_can_calculate_total_revenue_by_merchant
    skip
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst

    actual_1 = sales_analyst.all_merchant_invoices(12334194)
    assert_instance_of Array, actual_1
    assert_equal 13, actual_1.count

    actual_2 = sales_analyst.all_invoice_ids_for_merchant(12334194)
    assert_instance_of Array, actual_2
    assert_equal 13, actual_2.count

    actual_3 = sales_analyst.all_invoice_items_for_merchant(12334194)
    assert_equal 41, actual_3.count
    assert_instance_of InvoiceItem, actual_3[0]
    assert_instance_of Array, actual_3

    assert_equal 97_979.37, sales_analyst.revenue_by_merchant(12334194)
  end

  def test_the_most_sold_item_for_a_merchant
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sales_analyst = sales_engine.analyst
    assert_instance_of Hash, sales_analyst.sum_of_invoice_item_quantity(12334189)
    # assert_equal 23432, sales_analyst.sort_invoice_items_by_quantity(12334189)
    # assert_equal 232, sales_analyst.delete_the_lower_ranking_items(12334189)
    assert_instance_of Array, sales_analyst.finds_invoice_ids_from_most_sold_items(12334189)
    # assert_instance_of Hash, sales_analyst.eliminates_items_less_than_five(12334189)
    # assert_equal 345522, sales_analyst.finds_sorted_quantity_by_id(12334189)
require "pry"; binding.pry
    assert_equal 8678, sales_analyst.most_sold_item_for_merchant(12334189)


  end
end
