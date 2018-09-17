require_relative 'find_module'

module SAHelper
  include FindObjects

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
    @sales_engine.invoices.storage.reduce(Hash.new(0)) do |hash, invoice|
      hash[invoice.status] += 1
      hash
    end
  end

  def group_items_by_merchant_id
    @sales_engine.items.storage.group_by do |item|
      item.merchant_id
    end
  end

  def hash_of_merchants_with_one_item
    group_items_by_merchant_id.delete_if do |merchant_id, items|
      items.count > 1
    end
  end

  def finds_invoices_by_date(date)
    invoice_found = @sales_engine.invoices.find_all_by_created_at_date(date)
    invoice_found.map do |invoice|
      invoice.id
    end
  end

  def finds_invoice_items_by_date(date)
    fibd = finds_invoices_by_date(date)
    fibd.map do |invoice_id|
      @sales_engine.invoice_items.find_all_by_invoice_id(invoice_id)
    end.flatten
  end

  def finds_invoice_items_totals(date)
    fiibd = finds_invoice_items_by_date(date)
    fiibd.map do |invoice_item|
      invoice_item.quantity * invoice_item.unit_price
    end
  end

  def successful_invoices
    find_invoice_ids_for_successful_transactions.map do |invoice_id|
      @sales_engine.invoices.find_by_id(invoice_id)
    end
  end

  def grouped_invoices_by_merchants
    successful_invoices.group_by do |invoice|
      invoice.merchant_id
    end
  end

  def finds_grouped_invoice_ids
    grouped_invoices_by_merchants.keys.reduce(Hash.new(0)) do |hash, merchant_id|
      invoice_ids = grouped_invoices_by_merchants[merchant_id].map do |invoice|
        invoice.id
      end
      hash[merchant_id] = invoice_ids
      hash
    end
  end

  def finds_grouped_invoice_items
    finds_grouped_invoice_ids.reduce(Hash.new(0)) do |hash, (merchant_id, invoice_ids)|
      invoice_items = invoice_ids.map do |invoice_id|
        @sales_engine.invoice_items.find_all_by_invoice_id(invoice_id)
      end.flatten
      hash[merchant_id] = invoice_items
      hash
    end
  end

  def finds_invoice_totals
    finds_grouped_invoice_items.reduce(Hash.new(0)) do |hash, (merchant_id, invoice_items)|
      totals = invoice_items.map do |invoice_item|
        invoice_item.quantity * invoice_item.unit_price
      end
      hash[merchant_id] = totals
      hash
    end
  end

  def finds_pre_sorted_sums
    finds_invoice_totals.reduce(Hash.new(0)) do |hash, (merchant_id, totals)|
      hash[merchant_id] = sum_of_collection(totals)
      hash
    end
  end

  def sorted_merchants_by_revenue_totals
    finds_pre_sorted_sums.sort_by do |merchant_id, grand_totals|
      grand_totals
    end.to_h
  end

  def pending_invoices
    @sales_engine.invoices.storage.delete_if do |invoice|
      find_invoice_ids_for_successful_transactions.include?(invoice.id)
    end
  end

  def merchant_ids_from_pending_invoices
    pending_invoices.map do |invoice|
      invoice.merchant_id
    end.uniq
  end

  def all_merchant_invoices(merchant_id)
    @sales_engine.invoices.find_all_by_merchant_id(merchant_id)
  end

  def all_invoice_ids_for_merchant(merchant_id)
    ami = all_merchant_invoices(merchant_id)
    ami.map do |invoice|
      invoice.id
    end
  end

  def all_invoice_items_for_merchant(merchant_id)
    aiifm = all_invoice_ids_for_merchant(merchant_id)
    aiifm.map do |invoice_id|
      @sales_engine.invoice_items.find_all_by_invoice_id(invoice_id)
    end.flatten
  end

  def all_merchants_by_given_month(month)
    @sales_engine.merchants.find_all_by_created_at_date_month(month)
  end

  def hash_of_merchants_in_month_with_ids(month)
    ambgm = all_merchants_by_given_month(month)
    hash_of_merchants_with_ids = Hash.new(0)
    ambgm.each do |merchant|
      hash_of_merchants_with_ids[merchant] = merchant.id
    end
    hash_of_merchants_with_ids
  end

  def hash_of_merchants_with_items(month)
    homimwi = hash_of_merchants_in_month_with_ids(month)
    hash_of_merchants_with_items = Hash.new(0)
    items = @sales_engine.items
    homimwi.keys.each do |merchant|
      hash_of_merchants_with_items[merchant] = items.find_all_by_merchant_id(homimwi[merchant])
    end
    hash_of_merchants_with_items
  end

  def hash_of_merchants_with_only_one_item(month)
    homwi = hash_of_merchants_with_items(month)
    homwi.delete_if do |merchant, items|
      items.count > 1
    end
  end
end
