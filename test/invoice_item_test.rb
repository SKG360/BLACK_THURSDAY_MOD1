require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require 'time'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  def test_it_exists
    ii = InvoiceItem.new({
      id: 6,
      item_id: 7,
      invoice_id: 8,
      quantity: 1,
      unit_price: BigDecimal.new(10.99, 4),
      created_at: Time.now,
      updated_at: Time.now
    })

    assert_instance_of InvoiceItem, ii
  end

  def test_the_attributes
    ii = InvoiceItem.new({
      id: 6,
      item_id: 7,
      invoice_id: 8,
      quantity: 1,
      unit_price: BigDecimal.new(10.99, 4),
      created_at: Time.now,
      updated_at: Time.now
    })

    assert_equal 6, ii.id
    assert_equal 7, ii.item_id
    assert_equal 8, ii.invoice_id
    assert_equal 1, ii.quantity
  end

  def test_that_the_unit_price_is_big_decimal
    ii = InvoiceItem.new({
      id: 6,
      item_id: 7,
      invoice_id: 8,
      quantity: 1,
      unit_price: BigDecimal.new(109.9, 4),
      created_at: Time.now,
      updated_at: Time.now
    })

    assert_equal 1.099, ii.unit_price
    assert_instance_of BigDecimal, ii.unit_price
  end

  def test_the_create_updated_time_stamps
    ii = InvoiceItem.new({
      id: 6,
      item_id: 7,
      invoice_id: 8,
      quantity: 1,
      unit_price: BigDecimal.new(10.99, 4),
      created_at: Time.now,
      updated_at: Time.now
    })

    assert_instance_of Time, ii.created_at
    assert_instance_of Time, ii.updated_at
  end

  def test_the_unit_price_conversion_to_float
    ii = InvoiceItem.new({
      id: 6,
      item_id: 7,
      invoice_id: 8,
      quantity: 1,
      unit_price: BigDecimal.new(10.99, 4),
      created_at: Time.now,
      updated_at: Time.now
    })

    assert_equal 0.11, ii.unit_price_to_dollars
  end
end
