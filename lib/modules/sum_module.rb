module SumOfCollection

  def sum_of_collection(collection_of_things)
    sum = 0
    collection_of_things.each do |num|
      sum += num
    end
    sum
  end

end
