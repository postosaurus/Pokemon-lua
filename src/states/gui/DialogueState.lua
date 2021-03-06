DialogueState = Class{__includes = BaseState}

function DialogueState:init(text, onDialogueClose, canInput, def)
  self.textbox = Textbox(text, gPanels['bottomLeft'])
  if canInput == nil then self.canInput = true else self.canInput = canInput end

  self.onDialogueClose = onDialogueClose or function() print("__empty function__") end
end

function DialogueState:handleInput()
-- self.canInput)
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
