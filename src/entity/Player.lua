Player = Class{__includes = Entity}

function Player:init(world, def)
  Entity.init(self, world, def)
  Inventory.init(self, {
    {name = 'pokeball', amount = 5},
    {name = 'potion', amount = 5},
  })

end

function Player:addItem(name, amount)
  Inventory.addItem(self, name, amount)
end

function Player:removeItem(name, amount)
  Inventory.removeItem(self, name, amount)
end
