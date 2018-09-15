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

  def create(attributes)
    attributes[:id] = @storage[-1].id + 1
    @storage << @object_class.new(attributes)
  end

  def delete(id)
    item_to_delete = find_by_id(id)
    @storage.delete(item_to_delete)
  end
end
