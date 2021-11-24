DialogueState = Class{__includes = BaseState}

function DialogueState:init(text, onDialogueClose, def)
  if def == nil then
    self.textbox = Textbox(text, {x = 0, y = VIRTUAL_HEIGHT - 64, width = VIRTUAL_WIDTH, height = 64})
    self.canInput = true

  else
    if def.canInput == nil then self.canInput = true else self.canInput = def.canInput end
    if def.y == nil then def.y = VIRTUAL_HEIGHT - 64 end
    self.textbox = Textbox(text, def)
    self.canInput = def.canInput
  end


  self.onDialogueClose = onDialogueClose or function() print("__empty function__") end
end

function DialogueState:handleInput()
  if self.canInput then
        if love.keyboard.wasPressed('space') then
          self.textbox:next()
        end

        if self.textbox:isClosed() then
          self.textbox:toggle()
          self.textbox.displayChunks = self.lastChunks
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
  return not self.canInput
end

function DialogueState:render()
  self.textbox:render()
end
