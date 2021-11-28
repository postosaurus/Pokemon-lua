PlayerWalkState = Class{__includes = EntityBaseState}

function PlayerWalkState:init(world, entity)
  self.world = world
  self.entity = entity
end

function PlayerWalkState:enter()
  if not self.entity.bumped then
    self:attempMove()
  end
  self.entity.canInput = true
end

function PlayerWalkState:attempMove()
  self.entity:changeAnimation('walk-' .. self.entity.direction)
  -- self.entity.bumbed = false
  local level = self.world:getCurrentLevel()



  local toX = self.entity.mapX
  local toY = self.entity.mapY
  local dir = 0

  if self.entity.direction == 'up' then
    toY = toY - 1
  elseif self.entity.direction == 'down' then
    toY = toY + 1
  elseif self.entity.direction == 'right' then
    toX = toX + 1
  elseif self.entity.direction == 'left' then
    toX = toX - 1
  end


  --checking collision with map border and tiles/objects that are solid
  if toX < 1 or toX > level.tileWidth or toY < 1 or toY > level.tileHeight then
    self:stop()
    return
  else

    local tile = level:getTile(toX, toY, 'grid')
    print("\n")
    -- table.foreach(tile, print)
    -- table.foreach(tile.properties, print)
    -- if tile.properties then
    -- end

    print("\n")
    if tile then
      if tile.solid then
        self:stop()
        return
      end
    end



  local exitTrigger = level:getTile(self.entity.mapX, self.entity.mapY, 'grid')
  if exitTrigger then-- and exitTrigger.tigger then

      local contine = exitTrigger:onExit(exitTrigger.properties)(self, self.entity)
      if not contine then
        self:stop()
        self.entity.canInput = false
        return
      end
  end
end



  -- print(toX, toY)
  self.entity.mapX = toX
  self.entity.mapY = toY
  self.entity.bumped = false

  Timer.tween(.18, {
    [self.entity] = {
      x = (toX - 1) * TILESIZE,
      y = ((toY - 1) * TILESIZE) - self.entity.height / 2
    },

  }):finish(function()

    self.entity:setCollider(self.entity.direction)


    local enterTriger = level:getTile(self.entity.mapX, self.entity.mapY, 'grid')
    if enterTriger then
      if enterTriger.solid then
        self:stop()
        return
      end

      if enterTriger.trigger then

        local continue = enterTriger:onEnter(enterTriger.properties)(self, self.entity)

        if not continue then
          self.entity.canInput = false

        end
      end
    end


    print('checking new input in Playerwalk after everything')
    if not self.entity.canInput then
      self:stop()
      return
    end


    if love.keyboard.isDown('w') then
      self.entity.direction = 'up'
      self.entity:changeState('walk')

    elseif love.keyboard.isDown('d') then
      self.entity.direction = 'right'
      self.entity:changeState('walk')

    elseif love.keyboard.isDown('a') then
      self.entity.direction = 'left'
      self.entity:changeState('walk')

    elseif love.keyboard.isDown('s') then
      self.entity.direction = 'down'
      self.entity:changeState('walk')
    else
      self.entity:changeAnimation('idle-'.. self.entity.direction)
      self.entity:changeState('idle')
    end
  end)

end


function PlayerWalkState:stop()
  self.entity.bumbed = true
  self.entity:changeAnimation('idle-'..self.entity.direction)
  self.entity:changeState('idle')
  return
end
