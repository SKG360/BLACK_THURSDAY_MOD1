require 'time'
require_relative 'item_repository'
require_relative 'modules/standard_deviation_module'
require_relative 'modules/sum_module'

class SalesAnalyst
  include StandardDeviation
  include SumOfCollection

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def total_merchants
    @sales_engine.merchants.storage.length
  end

  def total_items
    @sales_engine.items.storage.length
  end

  def average_items_per_merchant
    (total_items.to_f / total_merchants).round(2)
  end

  def average_items_per_merchant_standard_deviation
    collection = total_items_per_merchant.values
    average = average_items_per_merchant
    standard_deviation(average, collection)
  end

  def total_items_per_merchant
    @sales_engine.items.storage.reduce(Hash.new(0)) do |hash, item|
      hash[item.merchant_id] += 1
      hash
    end
  end

  def merchant_id_with_high_item_count
    total_items_per_merchant.map do |merch, item|
      if item > (average_items_per_merchant + average_items_per_merchant_standard_deviation)
        merch
      end
    end.compact
  end

  def merchants_with_high_item_count #returns duplicate merch objects
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

  def array_of_merch_items(merchant_id)
    found_merchants = @sales_engine.items.storage.find_all do |item|
      item.merchant_id == merchant_id
    end
    found_merchants.map do |item|
      item.unit_price.to_f
    end
  end

  def sum_of_merch_items_array(merchant_id)
    collection_of_things = array_of_merch_items(merchant_id)
    sum_of_collection(collection_of_things)
  end

  def average_item_price_for_merchant(merchant_id)
    num_of_items = array_of_merch_items(merchant_id).length
    average = (sum_of_merch_items_array(merchant_id) / num_of_items).round(2)
    BigDecimal.new(average, 4)
  end

  def array_of_merchant_averages
    @sales_engine.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
  end

  def sum_of_averages
    collection_of_things = array_of_merchant_averages
    sum_of_collection(collection_of_things)
  end

  def average_average_price_per_merchant
    avg_avg = (sum_of_averages / array_of_merchant_averages.length).truncate(2)
  end

  def collection_of_unit_prices
    @sales_engine.items.storage.map do |item|
      item.unit_price.to_f
    end
  end

  def average_price_standard_deviation
    collection = collection_of_unit_prices
    average = average_average_price_per_merchant.to_f
    standard_deviation(average, collection)
  end

  def two_standard_devs_above
    two_stdevs = average_price_standard_deviation * 2
    return (average_average_price_per_merchant + two_stdevs).round(2)
  end

  def golden_items
    price_floor = two_standard_devs_above
    @sales_engine.items.storage.find_all do |item|
      item.unit_price > price_floor
    end
  end

  def total_invoices
    @sales_engine.invoices.all
  end

  def average_invoices_per_merchant
    (total_invoices.length.to_f / total_merchants).round(2)
  end

  def average_invoices_per_merchant_standard_deviation
    average = average_invoices_per_merchant
    collection = total_invoices_per_merchant.values
    standard_deviation(average, collection)
  end

  def total_invoices_per_merchant
    @sales_engine.invoices.storage.reduce(Hash.new(0)) do |hash, item|
      hash[item.merchant_id] += 1
      hash
    end
  end

  def two_standard_deviations
    average_invoices_per_merchant_standard_deviation * 2
  end

  def top_merchants_by_invoice_count_merchant_ids
    total_invoices_per_merchant.keys.find_all do |merchant_id|
      total_invoices_per_merchant[merchant_id] > (two_standard_deviations + average_invoices_per_merchant)
    end
  end

  def top_merchants_by_invoice_count
    top_merchants_by_invoice_count_merchant_ids.map do |merchant_id|
      @sales_engine.merchants.find_by_id(merchant_id)
    end
  end

  def bottom_merchants_by_invoice_count_merchant_ids
    total_invoices_per_merchant.keys.find_all do |merchant_id|
      total_invoices_per_merchant[merchant_id] < (average_invoices_per_merchant - two_standard_deviations)
    end
  end

  def bottom_merchants_by_invoice_count
    bottom_merchants_by_invoice_count_merchant_ids.map do |merchant_id|
      @sales_engine.merchants.find_by_id(merchant_id)
    end
  end

  def total_invoices_per_day_hash
    @sales_engine.invoices.storage.reduce(Hash.new(0)) do |hash, item|
      time = item.created_at.strftime("%A")
      hash[time] += 1
      hash
    end
  end

  def average_invoices_per_day
    (total_invoices.count) / 7
  end

  def standard_deviation_of_invoices_per_day
    average = average_invoices_per_day
    collection = total_invoices_per_day_hash.values
    standard_deviation(average, collection)
  end

  def top_days_by_invoice_count
    over_one_stdev = standard_deviation_of_invoices_per_day + average_invoices_per_day
    total_invoices_per_day_hash.keys.find_all do |day_key|
      total_invoices_per_day_hash[day_key] > over_one_stdev
    end
  end

  def invoice_status_hash
    @sales_engine.invoices.storage.reduce(Hash.new(0)) do |hash, item|
      hash[item.status] += 1
      hash
    end
  end

  def invoice_status(status)
    amt_invoices = invoice_status_hash[status]
    total = total_invoices.count
    ((amt_invoices.to_f / total) * 100).round(2)
  end
end
