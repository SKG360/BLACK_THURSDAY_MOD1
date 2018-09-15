module SAHelper

  def merchant_id_with_high_item_count
    total_items_per_merchant.map do |merch, item|
      if item > (average_items_per_merchant + average_items_per_merchant_standard_deviation)
        merch
      end
    end.compact
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

  def array_of_merchant_averages
    @sales_engine.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
  end

  def sum_of_averages
    collection_of_things = array_of_merchant_averages
    sum_of_collection(collection_of_things)
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

  def two_standard_deviations
    average_invoices_per_merchant_standard_deviation * 2
  end

  def top_merchants_by_invoice_count_merchant_ids
    total_invoices_per_merchant.keys.find_all do |merchant_id|
      total_invoices_per_merchant[merchant_id] > (two_standard_deviations + average_invoices_per_merchant)
    end
  end

  def bottom_merchants_by_invoice_count_merchant_ids
    total_invoices_per_merchant.keys.find_all do |merchant_id|
      total_invoices_per_merchant[merchant_id] < (average_invoices_per_merchant - two_standard_deviations)
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

  def invoice_status_hash
    @sales_engine.invoices.storage.reduce(Hash.new(0)) do |hash, item|
      hash[item.status] += 1
      hash
    end
  end
end
