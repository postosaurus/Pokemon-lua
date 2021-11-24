EntityWalkState = Class{__includes = EntityBaseState}

function EntityWalkState:init(world, entity)
  self.world = world
  self.entity = entity
end

function EntityWalkState:enter()
  if not self.entity.bumped then
    self:attempMove()
  end
end

function EntityWalkState:attempMove()
  self.entity:changeAnimation('walk-' .. self.entity.direction)
  local toX = self.entity.mapX
  local toY = self.entity.mapY
  local level = self.world:getCurrentLevel()
  table.foreach(level, print)
  if self.entity.direction == 'up' then
    toY = toY - 1
  elseif self.entity.direction == 'down' then
    toY = toY + 1
  elseif self.entity.direction == 'right' then
    toX = toX + 1
  elseif self.entity.direction == 'left' then
    toX = toX - 1
  end

  if toX < 1 or toX > level.tileWidth or toY < 1 or toY > level.tileHeight then
    self.entity.bumbed = true
    self.entity:changeAnimation('idle-'..self.entity.direction)
    self.entity:changeState('idle')
    return
  end

  local tile = level:getTile(toX, toY, 'grid')
  if tile.type == solid then
    self.entity.bumbed = true
    self.entity:changeAnimation('idle-'..self.entity.direction)
    self.entity:changeState('idle')
    return
  end

  self.entity.mapX = toX
  self.entity.mapY = toY
  self.entity.bumped = false

  Timer.tween(.24, {
    [self.entity] = {
      x = (toX - 1) * level.tileWidth,
      y = (toY - 1) * level.tileHeight}
  }):finish(function()
    self.entity:changeState('idle')
  end)
end
