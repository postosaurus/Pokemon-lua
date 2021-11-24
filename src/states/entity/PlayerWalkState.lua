PlayerWalkState = Class{__includes = EntityBaseState}

function PlayerWalkState:init(world, entity)
  self.world = world
  self.entity = entity
end

function PlayerWalkState:enter()
  if not self.entity.bumped then
    self:attempMove()
  end
end

function PlayerWalkState:attempMove()
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

  self.entity.mapX = toX
  self.entity.mapY = toY
  self.entity.bumped = false

  Timer.tween(.24, {
    [self.entity] = {
      x = (toX - 1) * level.tileWidth,
      y = (toY - 1) * level.tileHeight}
  }):finish(function()
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
