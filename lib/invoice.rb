class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(attributes_hash)
    @id = attributes_hash[:id]
    @customer_id = attributes_hash[:customer_id]
    @merchant_id = attributes_hash[:merchant_id]
    @status = attributes_hash[:status]
    @created_at = attributes_hash[:created_at]
    @updated_at = attributes_hash[:updated_at]
  end
end
