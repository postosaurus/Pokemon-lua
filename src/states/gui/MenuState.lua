MenuState = Class{__includes = BaseState}

function MenuState:init(def)
  self.menu = Menu(def)
  if def.update == nil then self.returnOnUpdate = false else self.returnOnUpdate = def.update end
end



function MenuState:enter()
  love.keyboard.keysPressed = {}
end

function MenuState:update(dt)
  self.menu:update(dt)

  return self.returnOnUpdate
end

function MenuState:render()
  self.menu:render()
end
