module FindObjects

  def all
    @storage
  end

  def find_by_id(id)
    @storage.find do |stored_item|
      stored_item.id == id
    end
  end

  def find_by_name(name)
    @storage.find do |item|
      item.name.downcase == name.downcase
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @storage.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @storage.find_all do |invoice|
      invoice.invoice_id == invoice_id
    end
  end

  def create(attributes)
    attributes[:id] = @storage[-1].id + 1
    @storage << @object_class.new(attributes)
  end

  def delete(id)
    item_to_delete = find_by_id(id)
    @storage.delete(item_to_delete)
  end

  def find_all_by_created_at_date(date)
    @storage.find_all do |item_obj|
      item_obj.created_at.strftime("%Y%m%d") == Time.parse(date.to_s).strftime("%Y%m%d")
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

  def find_all_successful_transactions
    @sales_engine.transactions.storage.find_all do |transaction|
      transaction.result == :success
    end
  end

  def find_invoice_ids_for_successful_transactions
    find_all_successful_transactions.map do |transaction|
      transaction.invoice_id
    end
  end

  def group_all_transactions_by_invoice_id
    @sales_engine.transactions.storage.group_by do |transaction|
      transaction.invoice_id
    end
  end

  def find_all_invoices_with_only_failed_results
    group_all_transactions_by_invoice_id.keys.delete_if do |invoice_id|
      group_all_transactions_by_invoice_id[invoice_id].all?(:failed)
    end
  end

  def find_all_by_created_at_date_month(month)
    @storage.find_all do |item_obj|
      item_obj.created_at.strftime("%m") == Time.parse(month.to_s).strftime("%m")
    end
  end
end
