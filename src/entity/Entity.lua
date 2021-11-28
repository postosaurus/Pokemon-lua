Entity = Class{}

function Entity:init(world, def)
  self.world = world

  self.width = def.width or TILESIZE
  self.height = def.height or TILESIZE
  self.offsetX = 4
  self.offsetY = 0
  self:setPosition(def.mapX or 12, def.mapY or 8)

  self.direction = 'down'
  self.bumped = false
  self:setCollider(self.direction)


  self:generateAnimations(def.animations)
  self.canInput = true
end

function Entity:setPosition(x, y)
  self.x = (x - 1) * self.width
  self.y =  ((y - 1) * self.height) - self.height / 2
  self.mapX = x
  self.mapY = y
end

function Entity:setCollider(direction)
  local x, y
  local width = 4
  local height = 4
  if direction == 'up' then
    x = self.x + self.width/2  - 5
    y = self.y - 8
    width = 10
    height = 8

  elseif direction == 'down' then
    x = self.x + self.width/2 - 5
    y = (self.y + self.height)
    width = 10
    height = 8

  elseif direction == 'left' then
      x = self.x + self.width / 2 - 16
      y = self.y + self.height / 2 - 4
    width = 8
    height = 8

  elseif direction == 'right' then
      x = self.x + self.width
      y = self.y + self.height / 2 - 4
    width = 8
    height = 8
  end

  self.collider = {
    x = x,
    y = y,
    width = width,
    height = height
  }
end

function Entity:setToOppositeDirection()

  if self.direction == 'up' then
    self.direction = 'down'
  elseif self.direction == 'down' then
    self.direction = 'up'
  elseif self.direction == 'right' then
    self.direction = 'left'
  elseif self.direction == 'left' then
    self.direction = 'right'
  end

end

function Entity:getAdjacentTile()
  local adjX = 0
  local adjY = 0

  if self.direction == 'up' then
    adjY = -1
  elseif self.direction == 'down' then
    adjY = 1
  elseif self.direction == 'right' then
    adjX = 1
  elseif self.direction == 'left' then
    adjX = -1
  end

  adjX = self.mapX + adjX
  adjY = self.mapY + adjY
  return adjX, adjY
end

function Entity:changeState(name)
  self.controller:change(name)
end

function Entity:collides(target)
  return not (self.x + self.width < target.x or self.x > target.x + target.width or
            self.y + self.height < target.y or self.y > target.y + target.height)
end

function Entity:generateAnimations(def)
  self.animations =  {}

  for k, animation in pairs(def) do

    self.animations[k] = Animation({
      frames = animation.frames,
      interval = animation.interval,
      looping = animation.looping,
      texture = animation.texture,
    })
  end
  self:changeAnimation('idle-'.. self.direction)
end

function Entity:changeAnimation(name)
  self.currentAnimation = self.animations[tostring(name)]
end

function Entity:handleInput()
  self.controller:handleInput()
  self:setCollider(self.direction)
end

function Entity:update(dt)
  self.controller:update(dt)
  self.currentAnimation:update(dt)
end

function Entity:render()
  self.controller:render()
  -- love.graphics.rectangle('line', self.x+self.offsetX, self.y+self.offsetY, self.width, self.height)
  love.graphics.rectangle('line', self.collider.x, self.collider.y, self.collider.width, self.collider.height)
  -- love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
end
