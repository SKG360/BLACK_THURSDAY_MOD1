require 'simplecov'
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
    price = BigDecimal.new(25)
    found_by_price = ir.find_all_by_price(price)
    assert_equal 79, found_by_price.count

    price = BigDecimal.new(20000)
    assert_equal 0, ir.find_all_by_price(price).length
  end

  def test_if_items_can_be_selected_by_price_range
    ir = ItemRepository.new("./data/items.csv")

    range_1 = (1000.00..1500.00)
    test_1 = ir.find_all_by_price_in_range(range_1)
    assert_equal 19, test_1.length

    range_2 = (10.00..150.00)
    test_2 = ir.find_all_by_price_in_range(range_2)
    assert_equal 910, test_2.length


  end

  def test_that_it_returns_all_the_items_sold_by_merchant
    ir = ItemRepository.new("./data/items.csv")
    merchant_id = 12334326
    found_by_merchant = ir.find_all_by_merchant_id(merchant_id)
    assert_equal 6, found_by_merchant.count
  end

  def test_it_can_create_new_items
    ir = ItemRepository.new("./data/items.csv")
    attributes = {
      name: "Capita Defenders of Awesome 2018",
      description: "This board both rips and shreds",
      unit_price: BigDecimal.new(399.99, 5),
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: 25
    }
    ir.create(attributes)
    assert_equal 263567475, ir.ir[-1].id
    assert_equal "Capita Defenders of Awesome 2018", ir.ir[-1].name
    assert_equal 25, ir.ir[-1].merchant_id
  end

  def test_if_it_can_update_certain_attributes
    ir = ItemRepository.new("./data/items.csv")
    attributes = {
      name: "Capita Defenders of Awesome 2018",
      description: "This board both rips and shreds",
      unit_price: BigDecimal.new(399.99, 5),
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: 25
    }
    ir.create(attributes)

    attributes_2 = {
      unit_price: BigDecimal.new(379.99, 5),
      merchant_id: 3030
    }

    ir.update(263567475, attributes_2)
    assert_equal 379.99, ir.ir[-1].unit_price
    assert_equal 25, ir.ir[-1].merchant_id
    refute_equal ir.ir[-1].updated_at, ir.ir[-1].created_at
  end

  def test_if_an_item_can_be_deleted
    ir = ItemRepository.new("./data/items.csv")
    attributes = {
      name: "Capita Defenders of Awesome 2018",
      description: "This board both rips and shreds",
      unit_price: BigDecimal.new(399.99, 5),
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: 25
    }
    ir.create(attributes)

    ir.delete(263567475)
    refute_equal 263567475, ir.ir[-1].id
  end


end
