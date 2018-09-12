require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    merchant_repository = MerchantRepository.new("./data/merchants.csv")
    assert_instance_of MerchantRepository, merchant_repository
  end

  def test_merchants_starts_empty
    merchant_repository = MerchantRepository.new("./test/abridged_list/mini_merchant_list.csv")
    assert_instance_of Array, merchant_repository.all
  end

  def test_merchant_repo_has_merchants
    merchant_repository = MerchantRepository.new("./test/abridged_list/mini_merchant_list.csv")

    assert_equal 4, merchant_repository.all.count
    assert_instance_of Array, merchant_repository.all
    assert merchant_repository.all.all? {|merchant| merchant.is_a?(Merchant)}
    assert_equal "Shopin1901", merchant_repository.all.first.name
  end

  def test_it_can_find_by_id
    merchant_repository = MerchantRepository.new("./test/abridged_list/mini_merchant_list.csv")

    actual = merchant_repository.find_by_id(2)
    assert_instance_of  Merchant, actual
    assert_equal "Candisart", actual.name
  end

  def test_find_by_id_returns_nil
    merchant_repository = MerchantRepository.new("./test/abridged_list/mini_merchant_list.csv")

    actual = merchant_repository.find_by_id(2345)
    assert_nil actual
  end

  def test_it_can_find_by_name
    merchant_repository = MerchantRepository.new("./test/abridged_list/mini_merchant_list.csv")

    actual  = merchant_repository.find_by_name("Candisart")
    assert_instance_of  Merchant, actual
    assert_equal "Candisart", actual.name
  end

  def test_find_name_can_return_nil
    merchant_repository = MerchantRepository.new("./test/abridged_list/mini_merchant_list.csv")

    actual = merchant_repository.find_by_name("Samuel")
    assert_nil actual
  end

  def test_it_can_find_all_by_name
    merchant_repository = MerchantRepository.new("./test/abridged_list/mini_merchant_list.csv")

    merchant_3 = merchant_repository.find_by_name("Candisart")
    merchant_2 = merchant_repository.find_by_name("MiniatureBikez")
    merchant_1 = merchant_repository.find_by_name("Shopin1901")

    assert_equal [], merchant_repository.find_all_by_name("Samuel")
    assert_equal [merchant_2], merchant_repository.find_all_by_name("MiniatureBikez")
    assert_equal [merchant_1, merchant_2], merchant_repository.find_all_by_name("In")
  end

  def test_it_can_create_new_merchant
    merchant_repository = MerchantRepository.new("./test/abridged_list/mini_merchant_list.csv")

    attributes = {name: "Jenn"}

    merchant_repository.create(attributes)

    assert_equal "Jenn", merchant_repository.merchants[-1].name
    assert_equal 5, merchant_repository.merchants[-1].id
  end

  def test_that_only_the_merchant_name_can_be_updated
    merchant_repository = MerchantRepository.new("./test/abridged_list/mini_merchant_list.csv")

    attributes_1 = {name: "Rocky"}
    attributes_2 = {id: 2, name: "LolaMarleys"}
    id = 4

    merchant_repository.update(id, attributes_1)

    assert_equal "Rocky", merchant_repository.merchants[-1].name
    assert_equal 4, merchant_repository.merchants[-1].id

    merchant_repository.update(id, attributes_2)

    assert_equal "LolaMarleys", merchant_repository.merchants[-1].name
    assert_equal 4, merchant_repository.merchants[-1].id
  end

  def test_that_a_merchant_can_be_deleted
    merchant_repository = MerchantRepository.new("./test/abridged_list/mini_merchant_list.csv")

    merchant_repository.delete(3)
    assert_nil merchant_repository.find_by_id(3)
  end

end
