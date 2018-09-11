require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require 'time'
require './lib/item'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_if_it_exists
    ir = ItemRepository.new("./data/items.csv")
    assert_instance_of ItemRepository, ir
  end

  def test_if_the_array_starts_empty
    ir = ItemRepository.new("./data/items.csv")
    assert_instance_of Array, ir.all
  end

  def test_if_the_item_repo_returns_all_items
    ir = ItemRepository.new("./data/items.csv")
    assert_equal 1367, ir.all.count
    assert_instance_of Array, ir.all
    assert true, ir.all.all? {|item| ir.is_a?(Item)}
    assert_equal "510+ RealPush Icon Set", ir.all[0].name
  end

  def test_if_it_finds_item_by_id
    ir = ItemRepository.new("./data/items.csv")
    id = 263538760
    assert_equal "Puppy blankie", ir.find_by_id(id).name

    id = 1
    assert_nil ir.find_by_id(id)
  end

  def test_if_it_finds_item_by_name
    ir = ItemRepository.new("./data/items.csv")
    name = "Puppy blankie"
    assert_equal 263538760, ir.find_by_name(name).id

    name = "Sales Engine"
    assert_nil ir.find_by_name(name)
  end

  def test_if_it_finds_all_with_a_description
    ir = ItemRepository.new("./data/items.csv")
    description = "A large Yeti of sorts, casually devours a cow as the others watch numbly."
    assert_equal 263550472, ir.find_all_with_description(description)[0].id

    description = "A LARGE yeti of SOrtS, casually devoURS a COw as the OTHERS WaTch NUmbly."
    assert_equal 263550472, ir.find_all_with_description(description)[0].id

    description = "Sales Engine is a relational database"
    assert_equal 0, ir.find_all_with_description(description).length
  end

  def test_if_it_can_find_all_items_by_price
    ir = ItemRepository.new("./data/items.csv")
    price = 1200
    assert_equal 41, ir.find_all_by_price(price).length

    price = 51_000
    assert_equal 0, ir.find_all_by_price(price).length
  end

  def test_if_items_can_be_selected_by_price_range
    skipr
    ir = ItemRepository.new("./data/items.csv")
    range = (1_000.00..1_500.00)
    assert_equal 20, ir.find_all_by_price_in_range(range)

  end

end
