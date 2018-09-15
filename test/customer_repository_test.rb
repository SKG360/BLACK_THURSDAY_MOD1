require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require 'time'
require './lib/customer'
require './lib/customer_repository'
require './lib/sales_engine'

class CustomerRepositoryTest < Minitest::Test
  def test_if_it_exists
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"
    })

    assert_instance_of CustomerRepository, se.customers
  end

  def test_it_return_all_customers
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :transactions => "./data/transactions.csv",
    :customers => "./data/customers.csv"
    })

    customer = se.customers
    assert_equal 1000, customer.all.count
  end

  def test_it_can_find_customers_by_id
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    })

    customer = se.customers
    actual = customer.find_by_id(100)

    assert_equal 100, actual.id
    assert_instance_of Customer, actual
  end

  def test_it_can_find_customers_by_first_name
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    })

    customer = se.customers
    assert_equal 8, customer.find_all_by_first_name("oe").length
    assert_equal 57, customer.find_all_by_first_name("NN").length
    assert_instance_of Customer, customer.find_all_by_first_name("oe")[0]
  end

  def test_it_can_find_customers_by_last_name
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    })

    customer = se.customers
    assert_equal 85, customer.find_all_by_last_name("On").length
    assert_equal 85, customer.find_all_by_last_name("oN").length
    assert_instance_of Customer, customer.find_all_by_last_name("On")[0]
  end

  def test_it_can_create_new_customer
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    })

    customer = se.customers

    attributes = {
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    customer.create(attributes)
    assert_equal 1001, customer.storage[-1].id
    assert_equal "Joan", customer.storage[-1].first_name
  end

  def test_it_can_update_customer
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    })

    attributes = {
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    customer = se.customers
    customer.create(attributes)

    attributes_2 = {last_name: "Smith", id: 987800}

    customer.update(1001, attributes_2)
    assert_equal 1001, customer.storage[-1].id
    assert_equal "Smith", customer.storage[-1].last_name
    refute_equal customer.storage[-1].updated_at, customer.storage[-1].created_at
  end

  def test_it_can_delete_customer
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    })

    attributes = {
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    customer = se.customers
    customer.create(attributes)
    customer.delete(1001)

    assert_nil customer.find_by_id(1001)
  end
end
