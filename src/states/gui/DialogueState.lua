DialogueState = Class{__includes = BaseState}

function DialogueState:init(text, canInput, onDialogueClose, def)

  self.textbox = Textbox({text = text, x = 0, y = VIRTUAL_HEIGHT - 64, width = VIRTUAL_WIDTH, height = 64})
  self.onDialogueClose = onDialogueClose or function() print("__empty function__") end


  if canInput == nil then self.canInput = true else self.canInput = canInput end
end

function DialogueState:handleInput()
  if self.canInput then
    if love.keyboard.wasPressed('space') then
      self.textbox:next()
    end
    if self.textbox:isClosed() then
      gStateStack:pop()
      self.onDialogueClose()
    end
  end
end

function DialogueState:enter()
  love.keyboard.keysPressed = {}
end

function DialogueState:exit()
  if not self.canInput then
    self:onDialogueClose()
  end
end

function DialogueState:update(dt)
  if self.canInput then
    self:handleInput()
  end

  return not self.canInput
end

function DialogueState:render()
  self.textbox:render()
end
