require 'bigdecimal'
require 'time'

class Item
  attr_reader :id,
              :created_at,
              :merchant_id

  attr_accessor :name,
                :updated_at,
                :description,
                :unit_price

  def initialize (data)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price  = BigDecimal.new((data[:unit_price].to_f/100), data[:unit_price].length)
    @created_at  = Time.parse(data[:created_at])
    @updated_at  = Time.parse(data[:updated_at])
    @merchant_id = data[:merchant_id].to_i
  end

  def unit_price_to_dollars
    price = @unit_price.to_f
  end

end
