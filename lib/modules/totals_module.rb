module Totals
  def total_merchants
    @sales_engine.merchants.storage.length
  end

  def total_items
    @sales_engine.items.storage.length
  end

  def total_items_per_merchant
    @sales_engine.items.storage.reduce(Hash.new(0)) do |hash, item|
      hash[item.merchant_id] += 1
      hash
    end
  end

  def total_invoices
    @sales_engine.invoices.all
  end

  def total_invoices_per_merchant
    @sales_engine.invoices.storage.reduce(Hash.new(0)) do |hash, item|
      hash[item.merchant_id] += 1
      hash
    end
  end

  def total_invoices_per_day_hash
    @sales_engine.invoices.storage.reduce(Hash.new(0)) do |hash, item|
      time = item.created_at.strftime("%A")
      hash[time] += 1
      hash
    end
  end

  def invoice_items_quantity_times_unit_price_array(invoice_items)
    invoice_items.map do |invoice_item|
      invoice_item.quantity * invoice_item.unit_price
    end
  end
end
