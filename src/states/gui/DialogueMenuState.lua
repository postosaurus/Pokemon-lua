DialogueMenuState = Class{__includes = BaseState}

function DialogueMenuState:init(text, subMenu, def)
  local choicesPanel = gPanels['bottomRight']
  choicesPanel.items = subMenu
  if def then
    choicesPanel.row = def.rows or 2
    choicesPanel.maxRows = def.maxRows or 3
    choicesPanel.closeOnSelect = true
    choicesPanel.height = def.height
    choicesPanel.width = def.width
  end

  self.textbox = Textbox(text, gPanels['bottomLeft'])
  self.canInput = true

  self.menu = Menu(choicesPanel)

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
