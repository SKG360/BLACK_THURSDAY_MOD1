module FindObjects

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

  def delete(id)
    item_to_delete = find_by_id(id)
    @storage.delete(item_to_delete)
  end
end
