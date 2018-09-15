class InvoiceItem
  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(data)
    @id = data[:id]
    @item_id = data[:item_id]
    @invoice_id = data[:invoice_id]
    @quantity = data[:quantity]
    @unit_price = data[:unit_price]
    @created_at  = Time.parse(data[:created_at].to_s)
    @updated_at  = Time.parse(data[:updated_at].to_s)
  end

  def unit_price_to_dollars
    @unit_price.to_f.round(2)
  end

end
