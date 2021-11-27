PlayState = Class {__includes = BaseState}

function PlayState:init()
  self.world = World()
end

function PlayState:enter()

end

function PlayState:handleInput()
  self.world:handleInput()
  -- if love.keyboard.wasPressed('up') then
  --   ACTIONS['move']('up', self.world.player)
  -- elseif love.keyboard.wasPressed('down') then
  --   ACTIONS['move']('down', self.world.player)
  -- end
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
