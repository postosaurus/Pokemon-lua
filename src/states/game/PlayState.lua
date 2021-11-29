PlayState = Class {__includes = BaseState}

function PlayState:init()
  self.world = World()
end

function PlayState:enter()
  love.keyboard.keysPressed = {}
end

function PlayState:handleInput()
  if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
    gStateStack:push(FieldMenuState(self.world))
  end
  self.world:handleInput()
end

function PlayState:update(dt)
  self.world:update(dt)

  return false
end

function PlayState:render()
  love.graphics.setFont(gFonts['small'])
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

  self.world:render()
end
