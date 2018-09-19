require 'time'
require_relative 'item_repository'
require_relative 'modules/standard_deviation_module'
require_relative 'modules/sum_module'
require_relative 'modules/sales_analyst_helper_methods_module'
require_relative 'modules/totals_module'

class SalesAnalyst
  include StandardDeviation
  include SumOfCollection
  include SAHelper
  include Totals

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def average_items_per_merchant
    (total_items.to_f / total_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    collection = total_items_per_merchant.values
    average = average_items_per_merchant
    standard_deviation(average, collection)
  end

  def merchants_with_high_item_count
    merch_agg = []
    merchant_id_with_high_item_count.find_all do |merchant_id|
      @sales_engine.merchants.all.map do |merch|
        if merch.id == merchant_id
          merch_agg << merch
        end
      end
    end
    merch_agg
  end

  def average_item_price_for_merchant(merchant_id)
    num_of_items = find_item_unit_price(merchant_id).length
    average = (sum_of_merch_items_array(merchant_id) / num_of_items).round(2)
    BigDecimal.new(average, 4)
  end

  def average_average_price_per_merchant
    avg_avg = (sum_of_averages / array_of_merchant_averages.length).truncate(2)
  end

  def golden_items
    two_stdevs = average_price_standard_deviation * 2
    price_floor = (average_average_price_per_merchant + two_stdevs).round(2)
    @sales_engine.items.storage.find_all do |item|
      item.unit_price > price_floor
    end
  end

  def average_invoices_per_merchant
    (total_invoices.length.to_f / total_merchants).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant
    collection = total_invoices_per_merchant.values
    standard_deviation(average, collection)
  end

  def top_merchants_by_invoice_count
    top_merchants_by_invoice_count_merchant_ids.map do |merchant_id|
      @sales_engine.merchants.find_by_id(merchant_id)
    end
  end

  def bottom_merchants_by_invoice_count
    bottom_merchants_by_invoice_count_merchant_ids.map do |merchant_id|
      @sales_engine.merchants.find_by_id(merchant_id)
    end
  end

  def top_days_by_invoice_count
    over_one_stdev = standard_deviation_of_invoices_per_day + average_invoices_per_day
    total_invoices_per_day_hash.keys.find_all do |day_key|
      total_invoices_per_day_hash[day_key] > over_one_stdev
    end
  end

  def invoice_status(status)
    amt_invoices = invoice_status_hash[status]
    total = total_invoices.count
    ((amt_invoices.to_f / total) * 100).round(2)
  end

  def invoice_paid_in_full?(invoice_id)
    invoices = @sales_engine.transactions.find_all_by_invoice_id(invoice_id)
    invoices.any? do |invoice|
      invoice.result == :success
    end
  end

  def invoice_total(invoice_id)
    invoice_items = @sales_engine.invoice_items.find_all_by_invoice_id(invoice_id)
    prices = invoice_items_quantity_times_unit_price_array(invoice_items)
    sum_of_collection(prices)
  end

  def merchants_with_only_one_item
    hash_of_merchants_with_one_item.keys.map do |merchant_id|
      @sales_engine.merchants.find_by_id(merchant_id)
    end
  end

  def total_revenue_by_date(date)
    fiit = finds_invoice_items_totals(date)
    sum_of_collection(fiit)
  end

  def top_revenue_earners(x = 20)
    merchants_ranked_by_revenue[0..(x-1)]
  end

  def merchants_ranked_by_revenue
    @sales_engine.merchants.storage.sort_by do |merchant|
      revenue_by_merchant(merchant.id)
    end.reverse
  end

  def merchants_with_pending_invoices
    merchant_ids_from_pending_invoices.map do |merchant_id|
      @sales_engine.merchants.find_by_id(merchant_id)
    end
  end

  def revenue_by_merchant(merchant_id)
    merchant_invoice_ids = all_invoice_ids_for_merchant(merchant_id)
    collection_of_totals = merchant_invoice_ids.map do |invoice_id|
      sum_of_invoice_items_by_invoice(invoice_id)
    end
    sum_of_collection(collection_of_totals)
  end

  def merchants_with_only_one_item_registered_in_month(month)
    homwooi = hash_of_merchants_with_only_one_item(month)
    homwooi.keys
  end

  def most_sold_item_for_merchant(merchant_id)
    fmsii = finds_most_sold_invoice_items(merchant_id)
    fmsii.keys.map do |invoice_item|
      @sales_engine.items.find_by_id(invoice_item.item_id)
    end
  end

  def invoice_items_per_invoice(invoice_id)
    invoice_items_of_invoice = @sales_engine.invoice_items.find_all_by_invoice_id(invoice_id)
  end

  def best_item_for_merchant(merchant_id)
    siibr = sorts_invoice_items_by_revenue(merchant_id)
    @sales_engine.items.find_by_id(siibr.keys[-1].item_id)
  end
end
