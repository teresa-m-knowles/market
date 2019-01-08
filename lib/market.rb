require 'pry'
class Market

  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    vendors.select do |vendor|
      vendor.check_stock(item) != 0
    end
  end

  def all_vendor_items
    vendors.map do |vendor|
      vendor.inventory.keys
    end.flatten.uniq
  end

  def sorted_item_list
    all_vendor_items.sort
  end

  def inventory_for_one_item(item)
    vendors.sum do |vendor|
      vendor.check_stock(item)
    end
  end

  def total_inventory
    inventory = Hash.new(0)

    all_vendor_items.each do |item|
      inventory[item] = inventory_for_one_item(item)
    end
    inventory
  end

  def check_enough_to_sell(item, quantity)
    if inventory_for_one_item(item) < quantity
      return false
    else
      return true
    end
  end

  def remove_item_from_stock(item, quantity)
    if check_enough_to_sell(item, quantity)
      vendors_that_sell(item).each do |vendor|
        if vendor.inventory[item] <= quantity
          quantity -= vendor.inventory[item]
          vendor.inventory[item] = 0
        else
          vendor.inventory[item] -=quantity
          quantity = 0
        end
      end
    else
      "Error, not enough items to remove."
    end
  end

  def sell(item, quantity)
    if !check_enough_to_sell(item, quantity)
      return false
    else
      remove_item_from_stock(item,quantity)
      return true
    end
  end

end
