Entity = Class{}

function Entity:init(world, def)
  self.world = world
  self:setPosition(def.mapX or 12, def.mapY or 8)

  self.width = def.width or TILESIZE
  self.height = def.height or TILESIZE
  
  self.direction = 'down'
  self.bumped = false

  self:generateAnimations(def.animations)
end

function Entity:setPosition(x, y)
  self.x = (x - 1) * self.width
  self.y =  ((y - 1) * self.height) - self.height / 2
  self.mapX = x
  self.mapY = y
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
end

function Entity:update(dt)
  self.controller:update(dt)
  self.currentAnimation:update(dt)
end

function Entity:render()
  self.controller:render()
end
