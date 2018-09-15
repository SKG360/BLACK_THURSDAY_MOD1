require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require 'time'
require './lib/transaction'

class TransactionTest < Minitest::Test
  def test_it_exists
    t = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
      })

    assert_instance_of Transaction, t
  end

  def test_the_attributes
    t = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
      })

    assert_equal 6, t.id
    assert_equal 8, t.invoice_id
    assert_equal "4242424242424242", t.credit_card_number
    assert_equal "0220", t.credit_card_expiration_date
    assert_equal "success", t.result
  end

  def test_the_create_updated_time_stamps
    t = Transaction.new({
      :id => 6,
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
      })

    assert_instance_of Time, t.created_at
    assert_instance_of Time, t.updated_at
  end
end
