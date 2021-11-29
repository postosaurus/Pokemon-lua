DialogueMenuState = Class{__includes = BaseState}

function DialogueMenuState:init(text, subMenu, def)
  self.textbox = Textbox(text, {x = 0, y = VIRTUAL_HEIGHT - 64, width = VIRTUAL_WIDTH, height = 64})
  self.canInput = true

  local offsetX = def.offsetX or 0
  local offsetY = def.offsetY or 0
  self.menu = Menu({
    x = VIRTUAL_WIDTH - 64 + offsetX, y = VIRTUAL_HEIGHT - 96 + offsetY,
    items = subMenu,
    closeOnSelect = true,
    rows = def.rows, maxRows = def.maxRows,
    width = def.width, height = def.height
  })

  self.onExit = onExit or function() end
end

function DialogueMenuState:handleInput()

end

function DialogueState:exit()

end

function DialogueMenuState:enter()
  love.keyboard.keysPressed = {}
end

function DialogueMenuState:update(dt)
  if self.canInput then
    self.menu:update(dt)
  end
  return not self.canInput
end

function DialogueMenuState:render()
  self.textbox:render()
  self.menu:render()
end
