EntityBaseState = Class{}

function EntityBaseState:init(world, entity)
  self.world = world
  self.entity = entity
end
function EntityBaseState:update(dt) end
function EntityBaseState:enter() end
function EntityBaseState:exit() end
function EntityBaseState:handleInput() end
function EntityBaseState:ProcessAI(params, dt) end

function EntityBaseState:render()
  local texture = self.entity.currentAnimation.texture
  print(texture, self.entity.currentAnimation:getFrame())
  love.graphics.draw(
    gTextures[texture],
    gFrames[texture][self.entity.currentAnimation:getFrame()],
    math.floor(self.entity.x),
    math.floor(self.entity.y))

end
