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
    @sales_engine.items.ir.map do |item|
      (item.unit_price.to_f - average_items_per_merchant).round(2)
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
    diff_aggregator
  end

  def divided_sum
    (sum_of_squared_differences / (total_items.length - 1)).round(2)
  end

  def average_items_per_merchant_standard_deviation
    Math.sqrt(divided_sum).round(2)
  end

end
