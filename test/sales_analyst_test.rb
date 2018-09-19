require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require 'time'
require './lib/sales_engine'
require './lib/sales_analyst'

class SalesAnalystTest < MiniTest::Test
  def test_if_it_exists
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    assert_instance_of SalesAnalyst, sales_engine.analyst
  end

  def test_it_returns_all_merchants
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    assert_equal 475, sa.total_merchants
  end

  def test_it_returns_all_items
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    assert_equal 1367, sa.total_items
  end

  def test_that_it_returns_the_avg_item_per_merchant
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    assert_equal 2.88, sa.average_items_per_merchant
  end

  def test_the_standard_deviation_avg_item_per_merchant
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    actual = sa.average_items_per_merchant_standard_deviation
    assert_equal 3.26, actual
  end

  def test_that_it_returns_the_merchants_that_sell_the_most_items
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    assert_equal 475, sa.total_items_per_merchant.count
    assert_equal 52, sa.merchant_id_with_high_item_count.count
    assert_equal 52, sa.merchants_with_high_item_count.count
  end

  def test_the_avg_item_price_per_merchant
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    assert_equal 64.7, sa.sum_of_merch_items_array(12334185)
    assert_equal 10.78, sa.average_item_price_for_merchant(12334185)
  end

  def test_it_makes_array_of_avg_item_prices
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    assert_equal 475, sa.array_of_merchant_averages.count
    assert_equal 166391.91, sa.sum_of_averages
    assert_equal 350.29, sa.average_average_price_per_merchant
  end

  def test_if_it_returns_an_array_of_golden_items
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    assert sa.golden_items[0], Item
    assert_equal 5, sa.golden_items.count
  end

  def test_it_calculates_average_invoices_per_merchant
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    assert_equal 4985, sa.total_invoices.length
    assert_equal 10.49, sa.average_invoices_per_merchant
  end

  def test_it_calculates_average_invoices_per_merchant_standard_deviation
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    actual = sa.average_invoices_per_merchant_standard_deviation
    assert_equal 3.29, actual
  end

  def test_it_can_find_total_invoices_per_merchant
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    assert_equal 475, sa.total_invoices_per_merchant.count
  end

  def test_it_can_calculate_two_standard_deviations
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    assert_equal 6.58, sa.two_standard_deviations
  end

  def test_it_can_return_top_merchants_merchant_ids
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    actual = sa.top_merchants_by_invoice_count_merchant_ids.count
    assert_equal 12, actual
  end

  def test_it_can_return_top_merchants
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    assert_equal 12, sa.top_merchants_by_invoice_count.count
  end

  def test_it_can_return_bottom_merchants
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    actual = sa.bottom_merchants_by_invoice_count_merchant_ids
    assert_instance_of Array, actual
    assert_equal 4, sa.bottom_merchants_by_invoice_count.count
  end

  def test_it_can_calculate_top_days_by_invoice_count
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    expected = {"Saturday"=>729, "Friday"=>701, "Wednesday"=>741,
                "Monday"=>696, "Sunday"=>708, "Tuesday"=>692, "Thursday"=>718}
    assert_equal expected, sa.total_invoices_per_day_hash
    assert_equal 712, sa.average_invoices_per_day
    assert_equal 18.07, sa.standard_deviation_of_invoices_per_day
    assert_equal ["Wednesday"], sa.top_days_by_invoice_count
  end

  def test_it_can_calculate_precantage_based_on_status
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    expected = {pending: 1473, shipped: 2839, returned: 673}
    assert_equal expected, sa.invoice_status_hash
    assert_equal 29.55, sa.invoice_status(:pending)
    assert_equal 56.95, sa.invoice_status(:shipped)
    assert_equal 13.5, sa.invoice_status(:returned)
  end

  def test_that_the_invoice_is_paid_in_full
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    assert_equal true, sa.invoice_paid_in_full?(1)
    assert_equal true, sa.invoice_paid_in_full?(200)
    refute sa.invoice_paid_in_full?(203)
    refute sa.invoice_paid_in_full?(204)
  end

  def test_it_calulates_invoice_total
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    assert_equal 21067.77, sa.invoice_total(1)
  end

  def test_it_returns_merchants_with_only_one_item
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst
    assert_instance_of Hash, sa.group_items_by_merchant_id
    assert_equal 243, sa.hash_of_merchants_with_one_item.keys.count
    assert_equal 243, sa.merchants_with_only_one_item.count
  end

  def test_it_can_calculate_total_revenue_date
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst
    assert_equal 8, sa.finds_invoice_items_totals("2009-02-07").count
    assert_equal 8, sa.finds_invoice_items_by_date("2009-02-07").count
    assert_equal 1, sa.finds_invoices_by_date("2009-02-07").count
    assert_equal 21067.77, sa.total_revenue_by_date("2009-02-07")
  end

  def test_it_can_return_the_top_revenue_earners
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    #assert_instance_of Hash, sa.grouped_invoices_by_merchants
    #assert_instance_of Hash, sa.finds_grouped_invoice_ids
    #assert_instance_of Array, sa.finds_grouped_invoice_ids.values
    #assert_instance_of Hash, sa.finds_grouped_invoice_items
    #assert_instance_of Hash, sa.finds_invoice_totals
    #assert_instance_of Hash, sa.finds_pre_sorted_sums
    #assert_instance_of BigDecimal, sa.finds_pre_sorted_sums.values[0]
    assert_equal 343344, sa.sorted_merchants_by_revenue_totals
  end

  def test_it_can_find_merchants_with_pending_invoices
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    assert_equal 4158, sa.find_all_successful_transactions.count
    assert_equal 4158, sa.find_invoice_ids_for_successful_transactions.count
    assert_equal 2175, sa.pending_invoices.count
    assert_equal 467, sa.merchant_ids_from_pending_invoices.count
    assert_instance_of Merchant, sa.merchants_with_pending_invoices[0]
    assert_equal 467, sa.merchants_with_pending_invoices.count
  end

  def test_it_can_calculate_total_revenue_by_merchant
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    assert_equal 2143253, sa.top_revenue_earners(20)
  end

  def test_it_finds_merchants_with_only_one_item_registered_in_month
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    actual = merchants_with_only_one_item_registered_in_month("March")
    assert_instance_of Array, sa.all_merchants_by_given_month("March")
    assert_instance_of Hash, sa.hash_of_merchants_in_month_with_ids("March")
    assert_instance_of Hash, sa.hash_of_merchants_with_items("March")
    assert_instance_of Array, sa.hash_of_merchants_with_items("March").values
    assert_instance_of Item, sa.hash_of_merchants_with_items("March").values[0][0]
    assert_instance_of Hash, sa.hash_of_merchants_with_only_one_item("March")
    assert_equal 21, sa.actual.count
  end

  def test_it_finds_most_sold_items_for_merchants
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst

    actual_1 = sa.total_quantities_of_invoice_items(12334189)
    assert_instance_of Hash, actual_1
    assert_instance_of InvoiceItem, actual_1.keys[0]

    actual_2 = sa.sorted_hash_of_invoice_items_and_quantities(12334189)
    assert_instance_of Hash, actual_2

    actual_3 = sa.reject_the_lower_ranking_items(12334189)
    assert_instance_of Hash, actual_3

    actual_4 = sa.finds_invoice_ids_from_most_sold_items(12334189)
    assert_equal 2, actual_4.count
    assert_instance_of Array, actual_4

    actual_5 = sa.reject_the_lower_ranking_items(12337105)

    assert_equal 213546564352, actual_5
  end

  def test_it_returns_best_item_for_merchant
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst
    actual_1 = sa.finds_all_invoice_items_associated_with_a_merchant(12334189)
    assert_instance_of Array, actual_1
    assert_instance_of InvoiceItem, actual_1[0]

    actual_2 = sa.finds_revenue_associated_with_invoice_items(12334189)
    assert_instance_of Hash, actual_2
    assert_instance_of InvoiceItem, actual_2.keys[0]
    assert_instance_of BigDecimal, actual_2.values[0]

    actual_3 = sa.sorts_invoice_items_by_revenue(12334189)
    assert_instance_of Hash, actual_3
    assert actual_3.values[-1] > actual_3.values[-2]

    actual_4 = sa.best_item_for_merchant(12334189)
    assert_equal 263516130, actual_4.id
    assert_instance_of Item, actual_4

    actual_5 = sa.best_item_for_merchant(12337105)
    assert_equal 263463003, actual_5.id
    assert_instance_of Item, actual_5
  end

  def test_it_returns_the_most_sold_item_for_merchant
    sales_engine = SalesEngine.from_csv({
      items: "./data/items.csv",
      merchants: "./data/merchants.csv",
      invoices: "./data/invoices.csv",
      invoice_items: "./data/invoice_items.csv",
      transactions: "./data/transactions.csv",
      customers: "./data/customers.csv"
    })

    sa = sales_engine.analyst
    actual_1 = sa.finds_quantities_with_invoice_items(12334189)
    assert_instance_of Hash, actual_1
    assert_instance_of InvoiceItem, actual_1.keys[0]
    assert_equal 9, actual_1.values[-1]

    actual_2 =  sa.sorts_invoice_items_by_quantity_sold(12334189)
    assert_instance_of Hash, actual_2
    assert actual_2.values[-1] > actual_2.values[0]

    actual_3 = sa.finds_most_sold_invoice_items(12334189).values[0]
    assert_equal 10, actual_3

    actual_4 = sa.most_sold_item_for_merchant(12334189)
    assert_instance_of Item, actual_4[0]
    assert_equal "Adult Princess Leia Hat", actual_4.first.name
  end
end
