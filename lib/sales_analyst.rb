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

end
