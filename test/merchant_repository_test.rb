require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    mr = MerchantRepository.new('./data/merchants.csv')
    assert_instance_of MerchantRepository, mr
  end

  def test_it_can_store_merchants
    mr = MerchantRepository.new('./test/abridged_list/mini_merchant_list.csv')
    assert_instance_of Array, mr.storage
    assert_instance_of Merchant, mr.storage[0]
  end

  def test_it_can_access_all_merchants
    mr = MerchantRepository.new('./test/abridged_list/mini_merchant_list.csv')

    assert_equal 4, mr.all.count
    assert_instance_of Array, mr.all
    assert mr.all.all? {|merchant| merchant.is_a?(Merchant)}
    assert_equal 'Shopin1901', mr.all.first.name
  end

  def test_it_can_find_by_id
    mr = MerchantRepository.new('./test/abridged_list/mini_merchant_list.csv')

    actual = mr.find_by_id(2)
    assert_instance_of Merchant, actual
    assert_equal 'Candisart', actual.name
  end

  def test_find_by_id_returns_nil_if_merchant_does_not_exist
    mr = MerchantRepository.new('./test/abridged_list/mini_merchant_list.csv')

    actual = mr.find_by_id(2345)
    assert_nil actual
  end

  def test_it_can_find_by_name
    mr = MerchantRepository.new('./test/abridged_list/mini_merchant_list.csv')

    actual_1 = mr.find_by_name('Candisart')
    assert_instance_of Merchant, actual_1
    assert_equal 'Candisart', actual_1.name

    actual_2 = mr.find_by_name('Samuel')
    assert_nil actual_2

    actual_3 = mr.find_by_name('CAND')
    assert_instance_of Merchant, actual_1
    assert_equal 'Candisart', actual_1.name
  end

  def test_it_can_find_all_by_name
    mr = MerchantRepository.new('./test/abridged_list/mini_merchant_list.csv')

    merchant_3 = mr.find_by_name('Candisart')
    merchant_2 = mr.find_by_name('MiniatureBikez')
    merchant_1 = mr.find_by_name('Shopin1901')

    assert_equal [], mr.find_all_by_name('Samuel')
    assert_equal [merchant_2], mr.find_all_by_name('MiniatureBikez')
    assert_equal [merchant_1, merchant_2], mr.find_all_by_name('In')
  end

  def test_it_can_create_new_merchant
    mr = MerchantRepository.new('./test/abridged_list/mini_merchant_list.csv')

    attributes = {name: 'Jenn'}

    mr.create(attributes)

    assert_equal 'Jenn', mr.storage[-1].name
    assert_equal 5, mr.storage[-1].id
  end

  def test_that_only_the_merchant_name_can_be_updated
    mr = MerchantRepository.new('./test/abridged_list/mini_merchant_list.csv')

    id_1 = 4
    attributes_1 = {name: 'Rocky'}
    attributes_2 = {id: 2, name: 'LolaMarleys'}

    mr.update(id_1, attributes_1)

    assert_equal 'Rocky', mr.storage[-1].name
    assert_equal 4, mr.storage[-1].id

    mr.update(id_1, attributes_2)

    assert_equal 'LolaMarleys', mr.storage[-1].name
    assert_equal 4, mr.storage[-1].id
  end

  def test_that_a_merchant_can_be_deleted
    mr = MerchantRepository.new('./test/abridged_list/mini_merchant_list.csv')

    mr.delete(3)
    assert_nil mr.find_by_id(3)
  end
end
