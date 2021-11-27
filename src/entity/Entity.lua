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
  -- if direction == 'up' then
  --   x = (self.x + self.width / 2) - (width / 2)  + self.offsetX
  --   y = self.y - height + self.offsetY
  --
  -- elseif direction == 'down' then
  --   x = (self.x + self.width / 2) - (width / 2) + self.offsetX
  --   y = (self.y + self.height) + self.offsetY
  --
  -- elseif direction == 'left' then
  --   x = (self.x) - width + self.offsetX
  --   y = (self.y + self.height / 2) - (height / 2) + self.offsetY
  --
  -- elseif direction == 'right' then
  --   x = (self.x + self.width) + self.offsetX
  --   y = (self.y + self.height / 2) - (height / 2) + self.offsetY
  --
  -- end

  self.collider = {
    x = self.x + self.offsetX / 2,
    y = self.y + self.offsetY,
    width = self.width - self.offsetX,
    height = self.height - self.offsetY,
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
  -- love.graphics.rectangle('line', self.collider.x, self.collider.y, self.collider.width, self.collider.height)
end
