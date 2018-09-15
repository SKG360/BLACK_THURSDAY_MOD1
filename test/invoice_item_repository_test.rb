require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require 'time'
require './lib/invoice_item'
require './lib/invoice_item_repository'
require './lib/sales_engine'

class InvoiceRepositoryTest < Minitest::Test
  def test_if_it_exists
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv"
    })

    assert_instance_of InvoiceItemRepository, se.invoice_items
  end

  def test_it_can_find_all
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
    })

    invoice_item = se.invoice_items

    assert_equal 21830, invoice_item.all.count
  end

  def test_it_can_find_by_id
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
    })

    invoice_item = se.invoice_items

    actual = invoice_item.find_by_id(10)
    assert_instance_of InvoiceItem, actual
    assert_equal 263523644, actual.item_id
    assert_nil invoice_item.find_by_id(434543)
  end

  def test_it_can_find_all_by_item_id
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
    })

    invoice_item = se.invoice_items

    assert_equal 11, invoice_item.find_all_by_item_id(263408101).count
    assert_instance_of InvoiceItem, invoice_item.find_all_by_item_id(263408101)[0]
    assert_equal [], invoice_item.find_all_by_item_id(98786)
  end

  def test_it_can_find_all_by_invoice_id
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
    })

    invoice_item = se.invoice_items

    assert_equal 3, invoice_item.find_all_by_invoice_id(100).count
    assert_equal [], invoice_item.find_all_by_invoice_id(987656)
  end

  def test_it_can_create_new_invoice_item
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
    })

    invoice_item = se.invoice_items

    attributes = {
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    }
    invoice_item.create(attributes)
    assert_equal 7, invoice_item.storage[-1].item_id
  end

  def test_it_can_update_only_quantity_and_unit_price
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
    })

    attributes = {
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    }
    invoice_item = se.invoice_items
    invoice_item.create(attributes)

    attributes_2 = {quantity: 13, item_id: 235}
    invoice_item.update(21831, attributes_2)

    actual = invoice_item.storage[-1]
    assert_equal 13, actual.quantity
    assert_equal 7, actual.item_id
    refute_equal actual.updated_at, actual.created_at
    assert_nil invoice_item.update(234334, {})
  end

  def test_it_deletes_invoices
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
    })

    attributes = {
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    }

    invoice_item = se.invoice_items
    invoice_item.create(attributes)
    invoice_item.delete(21831)

    assert_nil invoice_item.find_by_id(21831)
  end


end
