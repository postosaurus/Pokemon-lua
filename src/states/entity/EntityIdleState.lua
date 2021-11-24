EntityIdleState = Class{__includes = EntityBaseState}

function EntityIdleState:init(world, entity)
  self.world = world
  self.entity = entity
end
