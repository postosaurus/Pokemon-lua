Inventory = Class{}

function Inventory:init(def)
  -- self.world = world
  self.inventory = def or {}

end

function Inventory:addItem(name, amount)
  for i, item in ipairs(self.inventory) do
    print(i, item.name, item.amount, name, amount)


    if item.name == name then
      self.inventory[i] ={name = name, amount = item.amount + amount}
      return
    end
  end
  table.insert(self.inventory, {name = name, amount = amount})
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

function Inventory:hasItem(name, amount)
  local amount = amount or 1

  for i, item in ipais(self.inventory) do
    if item.name == name and item.amount >= amount then
      return true
    end
  end

  return
end
