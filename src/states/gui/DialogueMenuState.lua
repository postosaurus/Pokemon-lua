DialogueMenuState = Class{__includes = BaseState}

function DialogueMenuState:init(text, subMenu, def)
  self.textbox = Textbox(text, {x = 0, y = VIRTUAL_HEIGHT - 64, width = VIRTUAL_WIDTH, height = 64})
  self.canInput = true

  self.menu = Menu({
    x = VIRTUAL_WIDTH - 64, y = VIRTUAL_HEIGHT - 96,
    items = subMenu,
    closeOnSelect = true,
  })
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
