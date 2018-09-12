class SalesAnalyst
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end

  def total_merchants
    @sales_engine.merchants.all
    require "pry"; binding.pry
  end

  def total_items
    @sales_engine.items.ir
  end

end
