PlayerIdleState = Class{__includes = EntityBaseState}

function PlayerIdleState:init(world, entity)
  self.world = world
  self.entity = entity
end

function PlayerIdleState:handleInput()
  if self.entity.canInput then
    if love.keyboard.wasPressed('w') then
      self.entity.direction = 'up'
      self.entity:changeState('walk')

    elseif love.keyboard.wasPressed('d') then
      self.entity.direction = 'right'
      self.entity:changeState('walk')

    elseif love.keyboard.wasPressed('a') then
      self.entity.direction = 'left'
      self.entity:changeState('walk')

    elseif love.keyboard.wasPressed('s') then
      self.entity.direction = 'down'
      self.entity:changeState('walk')

    elseif love.keyboard.wasPressed('space') then
      local adjX, adjY = self.entity:getAdjacentTile()

      tile = self.world:getCurrentLevel():getTile(adjX, adjY, 'grid')
      if tile then
        print(tile.type)
          tile:onInteract(tile.properties)(self.world:getCurrentLevel(), self.entity)
      end

      for i, item in ipairs(self.world:getCurrentLevel().items) do
        -- print('checking items')
        if adjX == item.mapX and adjY == item.mapY then
          print('found item')
          item:onInteract(item)(self.world:getCurrentLevel(), self.entity)
        end
      end
    end
  end
end

function PlayerIdleState:update(dt)
  return false
end
