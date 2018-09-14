module StandardDeviation

  def standard_deviation(average, collection)
    difference_from_mean(average, collection)
    differences_squared(average, collection)
    sum_of_squared_differences(average, collection)
    divided_sum(average, collection)
    ds = divided_sum(average, collection)
    Math.sqrt(ds).round(2)
  end

  def difference_from_mean(average, collection)
    collection.map do |value|
      (average - value).round(2)
    end
  end

  def differences_squared(average, collection)
    dfm = difference_from_mean(average, collection)
    dfm.map do |difference|
      (difference ** 2).round(2)
    end
  end

  def sum_of_squared_differences(average, collection)
    ds = differences_squared(average, collection)
    diff_aggregator = 0
    ds.each do |diff|
      diff_aggregator += diff
    end
    diff_aggregator.round(2)
  end

  def divided_sum(average, collection)
    dfm = difference_from_mean(average, collection)
    ssd = sum_of_squared_differences(average, collection)
    (ssd / (dfm.length - 1)).round(2)
  end
end
