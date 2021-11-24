Entity = Class{}

function Entity:init(world, def)
  self.world = world

  self.mapX = def.mapX or 4
  self.mapY = def.mapY or 4
  self.width = def.width or TILESIZE
  self.height = def.height or TILESIZE

  self.x = (self.mapX -1) * self.width
  self.y =  (self.mapY - 1) * self.height

  self.direction = 'down'
  self.bumped = false

  self:generateAnimations(def.animations)
end

function Entity:changeState(name)
  self.controller:change(name)
end

function Entity:generateAnimations(def)
  self.animations =  {}

  for k, animation in pairs(def) do
    -- print(k, animation)
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
