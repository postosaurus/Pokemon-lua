Inventory = Class{}

function Inventory:init(def)
  -- self.world = world
  self.inventory = def or {}

end

function Inventory:addItem(name, amount)
  for i, item in ipairs(self.inventory) do

    if item.name == name then
      item.amount = item.amount + amount
      break
    end
    table.insert(self.inventory, {name = name, amount = amount})
  end
end

function Inventory:removeItem(name, amount)
  for i, item in ipairs(self.inventory) do
    if item.name == name then
      item.amount = item.amount - amount
      if item.amount <= 0 then
        table.remove(self.inventory, i)
      end
      break

    end
  end
end
