module SumOfCollection

  def sum_of_collection(collection_of_things)
    sum = 0
    collection_of_things.each do |num|
      sum += num
    end
    sum
  end

  def invoice_items_cost(invoice_item_collection)
    invoice_item_collection.map do |invoice_item|
      invoice_item.quantity * invoice_item.unit_price
    end
  end

end
