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

  def merchants_with_high_item_count
    # @sales_engine.items.ir.each do |item|
    #   average_items_per_merchant
    #   require "pry"; binding.pry
    # end
  end
end
