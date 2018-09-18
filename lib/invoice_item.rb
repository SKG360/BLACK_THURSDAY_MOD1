require 'time'
require 'bigdecimal'

class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :created_at

  attr_accessor :quantity,
                :unit_price,
                :updated_at

  def initialize(data)
    @id = data[:id].to_i
    @item_id = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity = data[:quantity].to_i
    @unit_price = BigDecimal.new(data[:unit_price].to_f / 100, 5)
    @created_at  = Time.parse(data[:created_at].to_s)
    @updated_at  = Time.parse(data[:updated_at].to_s)
  end

  def unit_price_to_dollars
    @unit_price.to_f.round(2)
  end
end
