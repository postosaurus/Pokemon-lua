EntityIdleState = Class{__includes = EntityBaseState}

function EntityIdleState:init(world, entity)
  self.world = world
  self.entity = entity
end

function EntityIdleState:enter()
  -- self.entity:changeAnimation('idle-'..self.entity.direction)
end
