Textbox = Class {}

function Textbox:init(text, def)
  self.text = tostring(text) or '__empty___'

  -- if def == nil then def = {} end

  self.panel = Panel(def)
  self.x = def.x or 0
  self.y = def.y or 0
  self.width = def.width or VIRTUAL_WIDTH
  self.height = def.height or 64

  self.paddingTop = def.paddingTop or 10
  self.paddingLeft = def.paddingLeft or 5

  self.font = def.font or gFonts['small']
  self.textColor = def.textColor or {0, 0, 0, 1}

  _, self.textChunks = self.font:getWrap(self.text, self.width - 8)

  local lineHeight = self.font:getHeight(self.textChunks[1])
  self.lines = math.floor(((self.height - self.paddingTop * 2) / (lineHeight + self.paddingTop)))
  -- print(self.width .. ' : ' .. #self.textChunks .. ' = ' .. self.lines)

  self.chunkCounter = 1
  self.endOfText = false
  self.closed = false

  self:next()
end

function Textbox:isClosed()
  return self.closed
end

function Textbox:toggle()
  self.panel:toggle()
end

function Textbox:next()
  if self.endOfText then
      self.lastChunks = self.displayChunks -- this is needed by DialogueMenuState to display the last chunk
      self.displayChunks = {}
      self.panel:toggle()
      self.closed = true
  else
    self.displayChunks = self:nextChunks()
  end
end

function Textbox:nextChunks()
    local chunks = {}

    -- print('before nextChunks_ ' ..self.chunkCounter)
    for i = self.chunkCounter, self.chunkCounter + self.lines do
      table.insert(chunks, self.textChunks[i])

      if i == #self.textChunks then
        self.endOfText = true
        return chunks
      end
    end

    self.chunkCounter = self.chunkCounter + self.lines + 1
    -- print('after nextChunks_ ' ..self.chunkCounter .. '  lines: ' ..tostring(math.max(self.lines, 1)))
    return chunks
end

function Textbox:handleInput()
  if not self:isClosed() then
    if love.keyboard.wasPressed('space') then
      self:next()
    end
  end
end

function Textbox:update(dt)
    self:handleInput()
end

function Textbox:render()
  self.panel:render()
  love.graphics.setColor(self.textColor)
  for i = 1, #self.displayChunks do
    love.graphics.printf(self.displayChunks[i],
        self.x + self.paddingLeft,
        (self.y + (i - 1) * 16) + self.paddingTop,
        self.x + self.width,
        'left'
    )
  end

  if not self.endOfText then
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.polygon('fill',
      self.x + self.width - 5 , self.y + self.height - 0,
      self.x + self.width - 0, self.y + self.height - 5,
      self.x + self.width - 10, self.y + self.height - 5
    )

    love.graphics.setColor(1, 1, 1, 1)
  end
end
