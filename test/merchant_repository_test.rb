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

  def test_find_by_name_returns_nil

    merchant_repository = MerchantRepository.new("./test/abridged_list/mini_merchant_list.csv")

    actual = merchant_repository.find_by_id(2345)
    assert_nil actual
  end

  def test_it_can_find_by_name

    merchant_repository = MerchantRepository.new("./test/abridged_list/mini_merchant_list.csv")

    actual  = merchant_repository.find_by_id(2)
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

end
