class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end
  def total_merchants
    @sales_engine.merchants.all
  end

  def total_items
    @sales_engine.items.ir
  end

  def average_items_per_merchant
    (total_items.length.to_f / total_merchants.length.to_f).round(2)
  end

  def difference_from_mean
    total_items_per_merchant.values.map do |value|
      (value - average_items_per_merchant).round(2)
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
    (sum_of_squared_differences / (total_items.length - 1)).round(2)
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

  def total_items_divided_by_avg_item
    total_items_per_merchant.map do |key, value|
      if value > average_items_per_merchant_standard_deviation
        [key, (value / average_items_per_merchant).round(2)]
      end
    end.compact
  end

  def merchant_id_with_high_item_count
    total_items_divided_by_avg_item.map do |merchant|
      if merchant[1] > (average_items_per_merchant + average_items_per_merchant_standard_deviation)
        merchant[0]
      end
    end.compact
  end

  def merchants_with_high_item_count
    merchant_id_with_high_item_count.find_all do |merchant_id|
      @sales_engine.merchants.all.map do |merch|
        if merch.id == merchant_id
          return [merch]
        end
      end
    end
  end
end
