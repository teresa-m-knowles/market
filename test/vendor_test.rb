require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'
require 'pry'

class VendorTest < Minitest::Test

  def test_it_exists
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_instance_of Vendor, vendor
  end

  def test_it_has_a_name
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_equal "Rocky Mountain Fresh", vendor.name
  end

  def test_it_starts_with_an_empty_inventory
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_equal Hash.new, vendor.inventory
  end

  def test_it_can_check_inventory_for_an_item
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_equal 0, vendor.check_stock("Peaches")
  end

  def test_it_can_stock_an_item
    vendor = Vendor.new("Rocky Mountain Fresh")

    vendor.stock("Peaches",30)

    assert_equal 30, vendor.check_stock("Peaches")

    vendor.stock("Peaches",25)

    assert_equal 55, vendor.check_stock("Peaches")
  end

  def test_it_can_return_a_hash_of_its_inventory
    vendor = Vendor.new("Rocky Mountain Fresh")

    vendor.stock("Peaches",30)
    vendor.stock("Peaches",25)
    vendor.stock("Tomatoes", 12)

    expected = {"Peaches" => 55, "Tomatoes" => 12}
    assert_equal expected, vendor.inventory
  end



end
