require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require 'time'
require_relative './lib/item'

class ItemTest < Minitest::Test
  def test_it_exists
    i = Item.new({ :id => 1, :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2})

    assert_instance_of Item, i
  end

  def test_it_can_return_id_as_integer
    i = Item.new({ :id => 1, :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2})

    assert_equal 1, i.id
  end

  def test_it_can_return_name_of_item
    i = Item.new({ :id => 1, :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2})

    assert_equal "Pencil", i.name
  end

  def test_it_can_return_description_of_item
    i = Item.new({ :id => 1, :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2})

    assert_equal "You can use it to write things", i.description
  end

  def test_it_can_return_unit_price_as_big_decimal
    i = Item.new({ :id => 1, :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2})

    assert_equal 10.99, i.unit_price
  end

  def test_it_can_return_instance_of_time_at_creation
    i = Item.new({ :id => 1, :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2})

    assert_instance_of Time, i.created_at
  end

  def test_it_can_return_instance_of_time_for_updates
    i = Item.new({ :id => 1, :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2})

    assert_instance_of Time, i.updated_at
  end

  def test_it_can_return_merchant_id_as_integer
    i = Item.new({ :id => 1, :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2})

    assert_equal 2, i.merchant_id
  end

  def test_it_can_return_unit_price_as_a_float
    i = Item.new({ :id => 1, :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2})

    assert_equal "$10.99", i.unit_price_to_dollars
  end
end
