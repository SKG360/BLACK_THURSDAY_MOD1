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
    group_items_by_merchant_id.reject do |merchant_id, items|
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
    invoice_item_collection = finds_invoice_items_by_date(date)
    invoice_items_cost(invoice_item_collection)
  end

  def successful_invoices
    find_invoice_ids_for_successful_transactions.map do |invoice_id|
      @sales_engine.invoices.find_by_id(invoice_id)
    end
  end

  #def grouped_invoices_by_merchants
  #  successful_invoices.group_by do |invoice|
  #    invoice.merchant_id
  #  end
  #end

  #def finds_grouped_invoice_ids
  #  grouped_invoices_by_merchants.keys.reduce(Hash.new(0)) do |hash, merchant_id|
  #    invoice_ids = grouped_invoices_by_merchants[merchant_id].map do |invoice|
  #      invoice.id
  #    end
  #    hash[merchant_id] = invoice_ids
  #    hash
  #  end
  #end

  def pending_invoices
    @sales_engine.invoices.storage.reject do |invoice|
      find_invoice_ids_for_successful_transactions.include?(invoice.id)
    end
  end

  def merchant_ids_from_pending_invoices
    pending_invoices.map do |invoice|
      invoice.merchant_id
    end.uniq
  end

  def find_all_successful_transactions_invoices
    find_invoice_ids_for_successful_transactions.map do |invoice_id|
      @sales_engine.invoices.find_by_id(invoice_id)
    end.uniq
  end

  def all_merchant_invoices(merchant_id)
    @sales_engine.invoices.find_all_by_merchant_id(merchant_id)
  end

  def all_returned_invoices
    @sales_engine.invoices.storage.find_all do |invoice|
      invoice.status == :returned
    end
  end

  def all_successful_merchant_invoices(merchant_id)
    all_invoices = all_merchant_invoices(merchant_id)
    all_invoices.find_all do |invoice|
      find_all_successful_transactions_invoices.include?(invoice)
    end
  end

  def all_invoice_ids_for_merchant(merchant_id)
    asmi = all_successful_merchant_invoices(merchant_id)
    asmi.map do |invoice|
      invoice.id
    end.uniq
  end

  #def all_invoice_items_for_merchant(merchant_id)
  #  aiifm = all_invoice_ids_for_merchant(merchant_id)
  #  aiifm.map do |invoice_id|
  #    @sales_engine.invoice_items.find_all_by_invoice_id(invoice_id)
  #  end.flatten
  #end

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
    homwi.reject do |merchant, items|
      items.count > 1
    end
  end

  #def all_invoice_ids_for_merchant(merchant_id)
  #  ami = all_merchant_invoices(merchant_id)
  #  ami.map do |invoice|
  #    invoice.id
  #  end
  #end

  def returned_invoices
    @sales_engine.invoices.storage.find_all do |invoice|
      invoice.status == :returned
    end
  end

  def shipped_invoices
    @sales_engine.invoices.storage.find_all do |invoice|
      invoice.status == :shipped
    end
  end

  def returned_invoice_ids
    returned_invoices.map do |invoice|
      invoice.id
    end
  end

  #def merchant_invoices_minus_returned(merchant_id)
  #  all_iids_for_m = all_invoice_ids_for_merchant(merchant_id)
  #  all_iids_for_m.reject do |invoice_id|
  #    returned_invoice_ids.include?(invoice_id)
  #  end
  #end

  #def merchant_invoices_minus_failed(merchant_id)
  #  invoices_minus_failed = merchant_invoices_minus_returned(merchant_id)
  #  invoices_minus_failed.reject do |invoice_id|
  #    find_all_invoices_with_only_failed_results.include?(invoice_id)
  #  end
  #end

  #def all_invoice_items_for_merchant(merchant_id)
#    aiimf = merchant_invoices_minus_returned(merchant_id)
#    aiimf.map do |invoice_id|
#      @sales_engine.invoice_items.find_all_by_invoice_id(invoice_id)
#    end.flatten
  #end

  #def total_quantities_of_invoice_items(merchant_id)
  #  all_ii_for_m = all_invoice_items_for_merchant(merchant_id)
  #  hash_of_quantities = Hash.new(0)
  #  all_ii_for_m.each do |invoice_item|
  #    hash_of_quantities[invoice_item] = invoice_item.quantity
  #  end
  #  hash_of_quantities
  #end

#  def total_revenues_of_invoice_items(merchant_id)
#    all_ii_for_m = all_invoice_items_for_merchant(merchant_id)
#    hash_of_revenues = Hash.new(0)
#    all_ii_for_m.each do |invoice_item|
#      hash_of_revenues[invoice_item] = invoice_item.quantity * invoice_item.unit_price
#    end
#    hash_of_revenues
#  end

#  def sorted_hash_of_invoice_items_and_quantities(merchant_id)
#    total_quant_of_ii = total_quantities_of_invoice_items(merchant_id)
#    total_quant_of_ii.sort_by do |invoice_item, total_quantities|
#      total_quantities
#    end.reverse.to_h
#  end
#
#  def sorted_hash_of_invoice_items_and_rev(merchant_id)
#    total_rev_of_ii = total_revenues_of_invoice_items(merchant_id)
#    total_rev_of_ii.sort_by do |invoice_item, total_rev|
#      total_rev
#    end.reverse.to_h
#  end

  def reject_the_lower_ranking_items(merchant_id, collection)
    collection.find_all do |invoice_item, quantity|
      quantity == collection.values[0]
    end.to_h
  end

  def finds_invoice_ids_from_most_sold_items(merchant_id, collection)
    collection.keys.map do |invoice_item|
      invoice_item.item_id
    end.uniq
  end
end
