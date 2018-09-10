require 'minitest/autorun'
require 'minitest/pride'
require_relative './lib/item'
require_relative './lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    item_repository = ItemRepository.new("./data/items.csv")
    assert_instance_of ItemRepository, item_repository
  end
end
