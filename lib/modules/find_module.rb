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

  def create(attributes = {created_at: Time.now})
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

  def find_all_by_created_at_date_month(month)
    @storage.find_all do |item_obj|
      item_obj.time.strftime("%m") == Time.parse(month.to_s).strftime("%m")
    end
  end
end
