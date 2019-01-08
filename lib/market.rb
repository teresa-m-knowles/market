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

end
