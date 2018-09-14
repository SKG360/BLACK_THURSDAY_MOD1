require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require 'time'
require './lib/invoice'

class InventoryTest < Minitest::Test
  def test_it_exists
    i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
    assert_instance_of Invoice, i
  end

  def test_it_can_return_id_as_integer
    i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })

    assert_equal 6, i.id
  end

  def test_it_returns_the_customer_id
    i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })

    assert_equal 7, i.customer_id
  end

  def test_it_returns_the_merchant_id
    i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })

    assert_equal 8, i.merchant_id
  end

  def test_it_returns_the_status
    i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })

    assert_equal "pending", i.status
  end

  def test_it_returns_the_time_it_was_created
    i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })

    assert_instance_of Time, i.created_at
  end

  def test_it_returns_the_time_it_was_created
    i = Invoice.new({
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })

    assert_instance_of Time, i.updated_at
  end
end
