require_relative 'item_repository'

class SalesAnalyst

  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def total_merchants
    @sales_engine.merchants.merchants.length
  end

  def total_items
    @sales_engine.items.ir.length
  end

  def average_items_per_merchant
    (total_items.to_f / total_merchants).round(2)
  end

  def difference_from_mean
    total_items_per_merchant.values.map do |value|
      (average_items_per_merchant - value).round(2)
    end
  end

  def differences_squared
    difference_from_mean.map do |difference|
      (difference ** 2).round(2)
    end
  end

  def sum_of_squared_differences
    diff_aggregator = 0
    differences_squared.each do |diff|
      diff_aggregator += diff
    end
    diff_aggregator.round(2)
  end

  def divided_sum
    (sum_of_squared_differences / (difference_from_mean.length - 1)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(divided_sum).round(2)
  end

  def total_items_per_merchant
    @sales_engine.items.ir.reduce(Hash.new(0)) do |hash, item|
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
    found_merchants = @sales_engine.items.ir.find_all do |item|
      item.merchant_id == merchant_id
    end
    found_merchants.map do |item|
      item.unit_price.to_f
    end
  end

  def sum_of_merch_items_array(merchant_id)
    sum = 0
    array_of_merch_items(merchant_id).each do |num|
      sum += num
    end
    sum
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
    sum = 0
    array_of_merchant_averages.each do |merch_avg|
      sum += merch_avg
    end
    sum
  end

  def average_average_price_per_merchant
    avg_avg = (sum_of_averages / array_of_merchant_averages.length).truncate(2)
  end

  def two_standard_devs_above
    two_stdevs = average_items_per_merchant_standard_deviation * 2
    
    return (average_average_price_per_merchant + two_stdevs).round(2)
  end

  def golden_items
    price_floor = two_standard_devs_above
    @sales_engine.items.ir.find_all do |item|
      item.unit_price > price_floor
    end
  end


end
